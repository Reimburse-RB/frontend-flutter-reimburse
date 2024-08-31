import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class RemoteDataSource {
  HttpService http = HttpService();

  static const String _getProfile = 'user/get-profile';

  Future<ProfileResponse> getProfile() async {
    final response = await http.post(endpoint: _getProfile);

    ProfileResponse profileResponse = ProfileResponse.fromJson(response);

    return profileResponse;
  }
}
