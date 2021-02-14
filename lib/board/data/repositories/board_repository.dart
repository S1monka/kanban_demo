import '../providers/board_api_provider.dart';
import '../models/Card.dart';
import 'package:meta/meta.dart';

class BoardRepository {
  final BoardApiProvider cardsApi = BoardApiProvider();

  Future<List<Card>> getCardsByBoardTab(
      {@required int tabIndex, @required String token}) async {
    final List cardsResponse =
        await cardsApi.getCardsByBoardTab(tabIndex: tabIndex, token: token);

    final List<Card> cardsList = [];

    cardsResponse.forEach((card) => cardsList.add(Card.fromMap(card)));

    return cardsList;
  }
}
