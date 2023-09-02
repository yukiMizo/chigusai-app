import 'package:flutter/material.dart';

import 'yushi_detail_screen.dart';

import 'package:chigusai_app/data/time_data.dart';

import 'package:chigusai_app/data/bunkasai/yushi_data.dart';

class YushiPage extends StatelessWidget {
  const YushiPage({super.key});

  final List<Tab> _tabs = const [
    Tab(text: '1日目', height: 30),
    Tab(text: '2日目', height: 30),
  ];

  Widget _buildYushiCard(BuildContext context, YushiDetailData yushiDetailData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          onTap: () => Navigator.of(context).pushNamed(YushiDetailScreen.routeName, arguments: yushiDetailData),
          leading: Text(
            yushiDetailData.startTime.getTimeAsString(),
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            yushiDetailData.title,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(yushiDetailData.place),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Text(
              '有志',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildTabSection() {
    return SliverPersistentHeader(
      floating: true,
      pinned: true,
      delegate: _StickyTabBarDelegate(
        TabBar(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: _tabs,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<YushiDetailData> yushiDataList = YushiData.yushiDataList;
    final List<YushiDetailData> yushiDataList1 = [];
    final List<YushiDetailData> yushiDataList2 = [];
    for (var data in yushiDataList) {
      if (data.startTime.day == GakusaiDay.bunkasai1) {
        yushiDataList1.add(data);
      } else if (data.startTime.day == GakusaiDay.bunkasai2) {
        yushiDataList2.add(data);
      }
    }
    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildHeaderSection(),
            _buildTabSection(),
          ];
        },
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: yushiDataList1.length,
                itemBuilder: (context, index) {
                  return _buildYushiCard(context, yushiDataList1[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: yushiDataList2.length,
                itemBuilder: (context, index) {
                  return _buildYushiCard(context, yushiDataList2[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//SliverPersistentHeaderDelegateを継承したTabBarを作る
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Theme.of(context).scaffoldBackgroundColor, child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
