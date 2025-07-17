import 'package:flutter_clean_architecture_1/features/profile/data/models/profile_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../../lib/features/profile/data/datasources/remote_datasource.dart';

import 'remote_datasource_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateNiceMocks([MockSpec<ProfileRemoteDataSoure>()])
void main() async {
  // Create mock object.
  var remoteDataSource = MockProfileRemoteDataSoure(); // fake class

  const int userId = 1;
  const int page = 1;

  final ProfileModel fakeProfileModel = ProfileModel(
    id: userId,
    email: "user1@gmail.com",
    firstName: "user",
    lastName: "1",
    avatar: "https://immage.com/$userId",
  );

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
}
