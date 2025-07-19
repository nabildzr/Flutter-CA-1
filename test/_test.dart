import 'package:flutter_clean_architecture_1/features/profile/data/datasources/remote_datasource.dart';

void main() async {
  // BENTUK TESTING SEDERHANA -> belum kelihatan persentase coverage nya
  final ProfileDataSourceImplementation remoteProfileDataSourceImplementation =
      ProfileDataSourceImplementation();

  // final response = await remoteProfileDataSourceImplementation.getAllUser(2);

  try {
    var response = await remoteProfileDataSourceImplementation.getUserById(112412);

    print(response.toJson());
  } catch (e) {
    print(e);
  }

  // for (var element in response) {
  //   print(element.toJson());
  // }
}
