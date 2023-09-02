import 'package:flutter/material.dart';

import 'yushi_detail_screen.dart';

import 'package:chigusai_app/data/bunkasai/yushi_data.dart';

class YushiPage extends StatelessWidget {
  const YushiPage({super.key});

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
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          '有志',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<YushiDetailData> yushiDataList = YushiData.yushiDataList;
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              _buildHeader(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: yushiDataList.length,
                itemBuilder: (context, index) {
                  return _buildYushiCard(context, yushiDataList[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
