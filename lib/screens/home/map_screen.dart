import 'package:flutter/material.dart';

import 'package:chigusai_app/themes/app_color.dart';

import 'package:chigusai_app/widgets/main_drawer.dart';
import '../notification/notification_screen.dart';

class MapScreen extends StatelessWidget {
  static const routeName = "/map-screen";
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Tab> tabs = [
      Tab(text: "1F"),
      Tab(text: "2F"),
      Tab(text: "3F"),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("マップ"),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
              icon: const Icon(Icons.notifications),
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: AppColors.lightText1,
            labelColor: AppColors.lightText1,
            tabs: tabs,
          ),
        ),
        drawer: const MainDrawer(),
        body: TabBarView(children: [
          SizedBox(),
          SizedBox(),
          SizedBox(),
        ]),
      ),
    );
  }
}
