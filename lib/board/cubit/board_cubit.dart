import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../data/models/Card.dart';
import '../data/repositories/board_repository.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  final BoardRepository _boardRepository = BoardRepository();
  final String authToken;

  BoardCubit({@required this.authToken}) : super(BoardInitial()) {
    assert(authToken != null);
    tabChanged(0);
  }

  void tabChanged(int tabIndex) async {
    emit(BoardTabChanged(tabIndex: tabIndex));
    emit(BoardTabLoadingInProgress());

    try {
      final cards = await _boardRepository.getCardsByBoardTab(
          tabIndex: tabIndex, token: authToken);

      emit(BoardTabLoadingSuccess(cards: cards, tabIndex: tabIndex));
    } catch (e) {
      emit(BoardTabLoadingFailure());
    }
  }
}
