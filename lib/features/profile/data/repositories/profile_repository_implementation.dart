import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_1/core/error/failure.dart';
import 'package:flutter_clean_architecture_1/features/profile/data/datasources/local_datasource.dart';
import 'package:flutter_clean_architecture_1/features/profile/data/datasources/remote_datasource.dart';
import 'package:flutter_clean_architecture_1/features/profile/data/models/profile_model.dart';
import 'package:flutter_clean_architecture_1/features/profile/domain/entities/profile.dart';
import 'package:flutter_clean_architecture_1/features/profile/domain/repositories/profile_repository.dart';
import 'package:hive/hive.dart';

class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileRemoteDataSoure profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;
  final HiveInterface hive;

  ProfileRepositoryImplementation({
    required this.profileRemoteDataSource,
    required this.profileLocalDataSource,
    required this.hive,
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // no available network
        // collect from local datasource

        List<ProfileModel> hasil = await profileLocalDataSource.getAllUser(
          page,
        );
        return Right(hasil);
      } else {
        // available network
        // collect from remote datasource

        List<ProfileModel> hasil = await profileRemoteDataSource.getAllUser(
          page,
        );
        // put last data profile
        var box = hive.box("profile_box");
        box.put('getAllUser', hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile?>> getUserById(int id) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // no available network
        // collect from local datasource

        ProfileModel hasil = await profileLocalDataSource.getUserById(id);
        return Right(hasil);
      } else {
        // available network
        // collect from remote datasource

        ProfileModel hasil = await profileRemoteDataSource.getUserById(id);
        // put last data profile
        var box = hive.box("profile_box");
        box.put("getUser", hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
