import 'package:flutter/material.dart';

import 'package:chigusai_app/data/zenkokikaku/zenkou_data.dart';

class ZenkouPage extends StatelessWidget {
  const ZenkouPage({super.key});

  Widget _buildZenkouCard(BuildContext context, ZenkouDetailData zenkouDetailData) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Text(zenkouDetailData.startTime.getTimeAsString()),
        title: Text(zenkouDetailData.title),
      ),
    );
  }

  Widget _buildHeader() {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '全校企画',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<ZenkouDetailData> zenkouDataList = ZenkouData.zenkouDataList;
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView.builder(
            itemCount: zenkouDataList.length,
            itemBuilder: (context, index) {
              return _buildZenkouCard(context, zenkouDataList[index]);
            },
          ),
        ),
      ],
    );
  }
}
