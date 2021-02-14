import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/enums.dart';

import '../../auth/cubit/auth_cubit.dart';
import '../cubit/board_cubit.dart';
import 'board_tab.dart';

class BoardScreen extends StatefulWidget {
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  void _tabChanged() =>
      context.read<BoardCubit>().tabChanged(_tabController.index);

  @override
  void initState() {
    _tabController = TabController(length: Tabs.values.length, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) _tabChanged();
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Tabs.values.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () => setState(
                () {
                  context.locale = context.locale == Locale("ru")
                      ? Locale('en')
                      : Locale("ru");
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => context.read<AuthCubit>().logout(),
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            onTap: (value) => _tabController.animateTo(value),
            labelPadding: EdgeInsets.symmetric(horizontal: 5),
            tabs: [
              Tab(
                text: tr("board.tabs.on_hold"),
              ),
              Tab(
                text: tr("board.tabs.in_progress"),
              ),
              Tab(
                text: tr("board.tabs.need_reveal"),
              ),
              Tab(
                text: tr("board.tabs.approved"),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: Tabs.values
              .map(
                (Tabs tab) => BoardTab(
                  currentTab: tab,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
