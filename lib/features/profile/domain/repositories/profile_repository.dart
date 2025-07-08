import 'package:flutter_clean_architecture_1/core/error/failure.dart';
import 'package:flutter_clean_architecture_1/features/profile/domain/entities/profile.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<Profile>>> getAllUser(int page); // maybe return empty list if no user found then return what? maka artinya jika gagal bisa menambahkan 2 data

  Future<Either<Failure, Profile?>> getUserById(int id);
}



