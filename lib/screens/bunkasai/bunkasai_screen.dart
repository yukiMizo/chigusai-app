import 'package:flutter/material.dart';

import 'package:chigusai_app/themes/app_color.dart';

import '../../widgets/main_drawer.dart';

import '../notification/notification_screen.dart';

import 'tenji/tenji_page.dart';
import 'engeki/engeki_page.dart';
import 'bukatsu/bukatsu_page.dart';
import 'yushi/yushi_page.dart';
import 'sonota/sonota_page.dart';

class BunkasaiScreen extends StatelessWidget {
  static const routeName = "/bunkasai-screen";
  const BunkasaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Tab> tabs = [
      Tab(text: "展示"),
      Tab(text: "演劇"),
      Tab(text: "有志"),
      Tab(text: "部活"),
      Tab(text: "その他"),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("文化祭"),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
              icon: const Icon(Icons.notifications),
            ),
          ],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: AppColors.lightText1,
            labelColor: AppColors.lightText1,
            tabs: tabs,
            isScrollable: true,
          ),
        ),
        drawer: const MainDrawer(),
        body: const TabBarView(children: [
          TenjiPage(),
          EngekiPage(),
          YushiPage(),
          BukatsuPage(),
          SonotaPage(),
        ]),
      ),
    );
  }
}
