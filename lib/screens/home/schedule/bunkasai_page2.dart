import 'package:flutter/material.dart';

import 'package:chigusai_app/data/bunkasai/engeki_data.dart';
import 'package:chigusai_app/data/bunkasai/yushi_data.dart';
import 'package:chigusai_app/data/zentai_schedule.dart';

class BunkasaiPage2 extends StatelessWidget {
  const BunkasaiPage2({super.key});

  final List<Tab> _tabs = const [
    Tab(text: "全体", height: 30),
    Tab(text: "演劇", height: 30),
    Tab(text: "有志", height: 30),
  ];

  Widget _buildZentaiCard(BuildContext context, ZentaiDetailData zentaiDetailData) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Text(zentaiDetailData.startTime.getTimeAsString()),
        title: Text(zentaiDetailData.title),
      ),
    );
  }

  Widget _buildEngekiCard(BuildContext context, EngekiDetailData engekiDetailData) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(engekiDetailData.startTime.getTimeAsString()),
            Text(engekiDetailData.endTime.getTimeAsString()),
          ],
        ),
        title: Text(engekiDetailData.title),
      ),
    );
  }

  Widget _buildYushiCard(BuildContext context, YushiDetailData yushiDetailData) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Text(yushiDetailData.startTime.getTimeAsString()),
        title: Text(yushiDetailData.title),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(30).copyWith(bottom: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "文化祭２日目",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    const List<ZentaiDetailData> zentaiDetailData = ZentaiData.zentaiDataList;
    const List<EngekiDetailData> engekiDetailData = EngekiData.engekiDataList;
    const List<YushiDetailData> yushiDetailData = YushiData.yushiDataList;

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
            ListView.builder(
              itemCount: engekiDetailData.length,
              itemBuilder: (context, index) {
                return _buildZentaiCard(context, zentaiDetailData[index]);
              },
            ),
            ListView.builder(
              itemCount: engekiDetailData.length,
              itemBuilder: (context, index) {
                return _buildEngekiCard(context, engekiDetailData[index]);
              },
            ),
            ListView.builder(
              itemCount: engekiDetailData.length,
              itemBuilder: (context, index) {
                return _buildYushiCard(context, yushiDetailData[index]);
              },
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
