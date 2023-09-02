import 'package:flutter/material.dart';

import '../../widgets/main_drawer.dart';

import '../notification/notification_screen.dart';

import 'taiikusai_detail_screen.dart';

import '../../data/taiikusai_data.dart';

import 'result_screen.dart';

class TaiikusaiScreen extends StatelessWidget {
  static const routeName = "/taiikusai-screen";
  const TaiikusaiScreen({super.key});

  Widget _buildTaiikusaiCard(BuildContext context, TaiikusaiDetailData taiikusaiDetailData) {
    return Card(
      child: ListTile(
        onTap: taiikusaiDetailData.info == null ? null : () => Navigator.of(context).pushNamed(TaiikusaiDetailScreen.routeName, arguments: taiikusaiDetailData),
        leading: Text(
          taiikusaiDetailData.startTime.getTimeAsString(),
          style: const TextStyle(fontSize: 20),
        ),
        title: Text(
          taiikusaiDetailData.title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Text(
          '体育祭',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<TaiikusaiDetailData> taiikusaiDataList = TaiikusaiData.taiikusaiDataList;
    return Scaffold(
      appBar: AppBar(
        title: const Text("体育祭"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _buildHeader(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taiikusaiDataList.length,
              itemBuilder: (context, index) {
                return _buildTaiikusaiCard(context, taiikusaiDataList[index]);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(ResultScreen.routeName),
        child: const Icon(Icons.scoreboard),
      ),
    );
  }
}
