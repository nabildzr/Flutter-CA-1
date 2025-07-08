import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_1/core/error/failure.dart';
import 'package:flutter_clean_architecture_1/features/profile/domain/entities/profile.dart';
import 'package:flutter_clean_architecture_1/features/profile/domain/repositories/profile_repository.dart';

class GetUser {
  final ProfileRepository profileRepository;
 
  const GetUser(this.profileRepository);

  Future<Either<Failure, Profile?>> execute(int id) async {
    return await profileRepository.getUserById(id);
  }
}