import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../constants/api.dart';

class BoardApiProvider {
  Future<List> getCardsByBoardTab(
      {@required int tabIndex, @required String token}) async {
    final cardsResponse =
        await http.get(api_url + 'cards/?row=$tabIndex', headers: {
      HttpHeaders.authorizationHeader: 'JWT ' + token,
    });

    return json.decode(utf8.decode(cardsResponse.bodyBytes));
  }
}
