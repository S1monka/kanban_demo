import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/board_cubit.dart';

class BoardTab extends StatelessWidget {
  final int currentTabIndex;

  const BoardTab({Key key, @required this.currentTabIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardCubit, BoardState>(
      builder: (context, state) {
        if (state is BoardTabChangeInProgress)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (state is BoardTabLoadingFailure)
          return Center(
            child: Text("Failed to retrive cards"),
          );
        else if (state is BoardTabLoadingSuccess &&
            state.tabIndex == currentTabIndex) {
          return state.cards.isEmpty
              ? Center(
                  child: Text("No cards on this tab"),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "ID: ${state.cards[index].id}",
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              state.cards[index].text,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.cards.length,
                );
        }

        return Container();
      },
    );
  }
}
