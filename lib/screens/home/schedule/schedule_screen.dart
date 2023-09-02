import 'package:chigusai_app/screens/home/schedule/zenkou_page.dart';
import 'package:flutter/material.dart';

import 'package:chigusai_app/themes/app_color.dart';

import '../../notification/notification_screen.dart';
import 'package:chigusai_app/widgets/main_drawer.dart';

import 'taiikusai_page.dart';
import 'bunkasai_page1.dart';
import 'bunkasai_page2.dart';

class ScheduleScreen extends StatelessWidget {
  static const routeName = "/schedule-screen";
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Tab> tabs = [
      Tab(text: "体育祭"),
      Tab(text: "文化祭1日目"),
      Tab(text: "文化祭2日目"),
      Tab(text: "全校企画"),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("日程"),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
              icon: const Icon(Icons.notifications),
            ),
          ],
          bottom: const TabBar(
            unselectedLabelColor: AppColors.lightText1,
            labelColor: AppColors.lightText1,
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        drawer: const MainDrawer(),
        body: const TabBarView(
          children: [
            TaiikusaiPage(),
            BunkasaiPage1(),
            BunkasaiPage2(),
            ZenkouPage(),
          ],
        ),
      ),
    );
  }
}
