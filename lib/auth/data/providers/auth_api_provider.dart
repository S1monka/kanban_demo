import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../constants/api.dart';

class AuthApiProvider {
  Future<Map> logIn(
      {@required String username, @required String password}) async {
    final loginResponse = await http.post(
      api_url + "users/login/",
      body: {"username": username, "password": password},
    );

    return json.decode(loginResponse.body);
  }
}
