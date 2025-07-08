import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_1/core/error/failure.dart';
import 'package:flutter_clean_architecture_1/features/profile/domain/entities/profile.dart';
import 'package:flutter_clean_architecture_1/features/profile/domain/repositories/profile_repository.dart';

class GetAllUser {
  final ProfileRepository profileRepository;

  const GetAllUser(this.profileRepository);

  Future<Either<Failure,List<Profile>>> execute(int page) async {
    return await profileRepository.getAllUser(page);
  }
}
