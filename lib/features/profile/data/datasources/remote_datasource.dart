import 'dart:convert';

import 'package:flutter_clean_architecture_1/core/error/exception.dart';
import 'package:flutter_clean_architecture_1/features/profile/data/models/profile_model.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemoteDataSoure {
  Future<List<ProfileModel>> getAllUser(int page);

  Future<ProfileModel> getUserById(int id);
}

class ProfileDataSourceImplementation extends ProfileRemoteDataSoure {

  final http.Client client;

  ProfileDataSourceImplementation({required this.client});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    final response = await client.get(
      Uri.parse('https://reqres.in/api/users?page=2'),
      headers: {
        'x-api-key': 'reqres-free-v1',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);
      List<dynamic> data = dataBody["data"];
      if(data.isEmpty) {
      throw EmptyException(message: "Empty Data - Error");

      }
      return ProfileModel.fromJsonList(data);
    } else if (response.statusCode == 404) {
      throw StatusCodeException(message: "Data not found - Error");
    } else {
      throw GeneralException(message: "Cannot get data.");
    }
  }

  @override
  Future<ProfileModel> getUserById(int id) async {
    final response = await client.get(
      Uri.parse('https://reqres.in/api/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'reqres-free-v1',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);
      Map<String, dynamic> data = dataBody["data"] ?? [];
      return ProfileModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw EmptyException(message: "Data not found - Error");
    } else {
      throw GeneralException(message: "Cannot get data");
    }
  }
}
