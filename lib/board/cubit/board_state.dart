part of 'board_cubit.dart';

abstract class BoardState extends Equatable {
  const BoardState();

  @override
  List<Object> get props => [];
}

class BoardInitial extends BoardState {}

class BoardTabChanged extends BoardState {
  final int tabIndex;
  BoardTabChanged({@required this.tabIndex});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'BoardTabChanged(tabIndex: $tabIndex)';
}

class BoardTabLoadingInProgress extends BoardState {}

class BoardTabLoadingSuccess extends BoardState {
  final List<Card> cards;
  final int tabIndex;
  BoardTabLoadingSuccess({@required this.cards, @required this.tabIndex});

  @override
  List<Object> get props => [cards];

  @override
  String toString() =>
      'BoardTabLoadingSuccess(cards: $cards, tabIndex: $tabIndex)';
}

class BoardTabLoadingFailure extends BoardState {}
