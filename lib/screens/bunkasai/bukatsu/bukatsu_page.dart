import 'package:flutter/material.dart';

import 'bukatsu_detail_screen.dart';

import 'package:chigusai_app/data/bunkasai/bukatsu_data.dart';

class BukatsuPage extends StatelessWidget {
  const BukatsuPage({super.key});

  Widget _buildBukatsuCard(BuildContext context, BukatsuDetailData bukatsuDetailData) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(BukatsuDetailScreen.routeName, arguments: bukatsuDetailData),
        title: Text(
          bukatsuDetailData.club,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(bukatsuDetailData.place),
      ),
    );
  }

  Widget _buildHeader() {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          '部活',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<BukatsuDetailData> bukatsuDataList = BukatsuData.bukatsuDataList;
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
                itemCount: bukatsuDataList.length,
                itemBuilder: (context, index) {
                  return _buildBukatsuCard(context, bukatsuDataList[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
