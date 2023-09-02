import 'package:flutter/material.dart';

import 'package:chigusai_app/data/taiikusai_data.dart';

class TaiikusaiPage extends StatelessWidget {
  const TaiikusaiPage({super.key});

  Widget _buildTaiikusaiCard(BuildContext context, TaiikusaiDetailData taiikusaiDetailData) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: Text(taiikusaiDetailData.startTime.getTimeAsString()),
        title: Text(taiikusaiDetailData.title),
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
              '体育祭',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<TaiikusaiDetailData> taiikusaiDataList = TaiikusaiData.getTaiikusaiDataList;

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView.builder(
            itemCount: taiikusaiDataList.length,
            itemBuilder: (context, index) {
              return _buildTaiikusaiCard(context, taiikusaiDataList[index]);
            },
          ),
        ),
      ],
    );
  }
}
