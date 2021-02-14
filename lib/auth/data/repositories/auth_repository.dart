import 'package:meta/meta.dart';

import '../providers/auth_api_provider.dart';

class AuthRepository {
  final AuthApiProvider authApi = AuthApiProvider();

  Future<String> logIn({
    @required String username,
    @required String password,
  }) async {
    Map loginResponse =
        await authApi.logIn(username: username, password: password);

    bool isTokenGiven = loginResponse['token'] is String;

    if (!isTokenGiven)
      throw ArgumentError(
          (loginResponse['non_field_errors'] as List).join("\n"));

    return loginResponse['token'];
  }
}
