import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/cubit/auth_cubit.dart';
import '../cubit/board_cubit.dart';
import 'board_tab.dart';

class BoardScreen extends StatefulWidget {
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> _boardTabs = [
    Tab(
      text: "On hold",
    ),
    Tab(
      text: "In progress",
    ),
    Tab(
      text: "Needs reveal",
    ),
    Tab(
      text: "Approved",
    )
  ];

  TabController _tabController;
  int _currentTabIndex = 0;

  void _tabChanged() =>
      context.read<BoardCubit>().tabChanged(_tabController.index);

  @override
  void initState() {
    _tabController = TabController(length: _boardTabs.length, vsync: this);

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
      length: _boardTabs.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => context.read<AuthCubit>().logout(),
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            onTap: (value) => _tabController.animateTo(value),
            labelPadding: EdgeInsets.symmetric(horizontal: 5),
            tabs: _boardTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _boardTabs
              .map(
                (_) => BoardTab(
                  currentTabIndex: _currentTabIndex++,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
