import 'package:reimburse_rb/data/datasource/remote/remote.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';

class Repository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  Future<ProfileResponse> getProfile() async => await remoteDataSource.getProfile();
}
