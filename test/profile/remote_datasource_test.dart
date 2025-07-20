import 'dart:convert';

import 'package:flutter_clean_architecture_1/core/error/exception.dart';
import 'package:flutter_clean_architecture_1/features/profile/data/models/profile_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../../lib/features/profile/data/datasources/remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'remote_datasource_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateNiceMocks([
  MockSpec<ProfileRemoteDataSoure>(),
  MockSpec<http.Client>(),
])
void main() async {
  // Create mock object.
  var remoteDataSource = MockProfileRemoteDataSoure(); // fake class

  MockClient mockClient = MockClient();

  var remoteDataSourceImplementation = ProfileDataSourceImplementation(
    client: mockClient,
  );

  const int userId = 1;
  const int page = 1;
  Uri urlGetAllUser = Uri.parse("https://reqres.in/api/users?page=$page");
  Uri urlGetUser = Uri.parse("https://reqres.in/api/users/$userId");

  Map<String, dynamic> fakeDataJson = {
    "id": userId,
    "email": "user$userId@gmail.com",
    "first_name": "user",
    "last_name": "$userId",
    "avatar": "https://image.com/$userId",
  };

  final ProfileModel fakeProfileModel = ProfileModel.fromJson(fakeDataJson);

  group("Profile Remote Data Source - ", () {
    group("getUser", () {
      test('BERHASIL (200)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          remoteDataSource.getUserById(1),
        ).thenAnswer((_) async => fakeProfileModel);

        try {
          // PASTI BERHASIL
          var response = await remoteDataSource.getUserById(1);
          expect(response, fakeProfileModel);
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        }
      });

      test('GAGAL', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(remoteDataSource.getUserById(1)).thenThrow(Exception());

        try {
          var response = await remoteDataSource.getUserById(1);
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        } catch (e) {
          // PASTI BERHASIL
          expect(e, isException);
        }
      });
    });

    group("getAllUser()", () {
      test('BERHASIL (200)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          remoteDataSource.getAllUser(1),
        ).thenAnswer((_) async => [fakeProfileModel]);

        try {
          // PASTI BERHASIL
          var response = await remoteDataSource.getAllUser(1);
          expect(response, [fakeProfileModel]);
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        }
      });

      test('GAGAL', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(remoteDataSource.getAllUser(1)).thenThrow(Exception());

        try {
          var response = await remoteDataSource.getAllUser(1);
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        } catch (e) {
          // PASTI BERHASIL
          expect(e, isException);
        }
      });
    });
  });

  // implementation
  group("Profile remote data source Implementation", () {
    group("getUser", () {
      test('BERHASIL (200)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          mockClient.get(urlGetUser, headers: anyNamed('headers')),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode({"data": fakeDataJson}), 200),
        );

        try {
          // PASTI BERHASIL
          var response = await remoteDataSourceImplementation.getUserById(
            userId,
          );
          expect(response, fakeProfileModel);
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI - ERROR : $e");
        }
      });

      test('GAGAL (404)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          mockClient.get(urlGetUser, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response(jsonEncode({}), 404));
        try {
          // PASTI BERHASIL
          var response = await remoteDataSourceImplementation.getUserById(
            userId,
          );
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        } on EmptyException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        }
      });

      test('GAGAL (500)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          mockClient.get(urlGetUser, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response(jsonEncode({}), 500));

        try {
          // PASTI BERHASIL
          var response = await remoteDataSourceImplementation.getUserById(
            userId,
          );
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        } on EmptyException catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        } catch (e) {
          expect(e, isException);
        }
      });
    });

    group("getAllUser", () {
      test('BERHASIL (200)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          mockClient.get(urlGetAllUser, headers: anyNamed('headers')),
        ).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
              "data": [fakeDataJson],
            }),
            200,
          ),
        );

        try {
          // PASTI BERHASIL
          var response = await remoteDataSourceImplementation.getAllUser(page);
          expect(response, [fakeProfileModel]);
        } on EmptyException catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        } on StatusCodeException catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        }
      });

      test('GAGAL (EMPTY)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          mockClient.get(urlGetAllUser, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response(jsonEncode({"data": []}), 404));
        try {
          // PASTI BERHASIL
          var response = await remoteDataSourceImplementation.getAllUser(page);
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        } on EmptyException catch (e) {
          expect(e, isException);
        } on StatusCodeException catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        }
      });

      test('GAGAL (404)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          mockClient.get(urlGetAllUser, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response(jsonEncode({}), 404));
        try {
          // PASTI BERHASIL
          var response = await remoteDataSourceImplementation.getAllUser(page);
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        } on EmptyException catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        } on StatusCodeException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        }
      });

      test('GAGAL (500)', () async {
        //  stub -> kondisi untuk mempalsukan
        // (proses stubbing)
        when(
          mockClient.get(urlGetAllUser, headers: anyNamed('headers')),
        ).thenAnswer((_) async => http.Response(jsonEncode({}), 500));

        try {
          // PASTI BERHASIL
          var response = await remoteDataSourceImplementation.getAllUser(page);
          fail("TIDAK MUNGKIN TERJADI - ERROR");
        }on EmptyException catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        } on StatusCodeException catch (e) {
          fail("TIDAK MUNGKIN TERJADI");
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });
}
