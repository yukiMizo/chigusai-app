import 'package:flutter/material.dart';

import 'tenji_detail_screen.dart';

import 'package:chigusai_app/data/bunkasai/tenji_data.dart';

class TenjiPage extends StatelessWidget {
  const TenjiPage({super.key});

  Widget _buildTenjiCard(BuildContext context, TenjiDetailData tenjiDetailData) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(TenjiDetailScreen.routeName, arguments: tenjiDetailData),
        leading: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage(tenjiDetailData.imgPath))),
        ),
        title: Text(tenjiDetailData.hr),
        subtitle: Text(tenjiDetailData.pr),
        trailing: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(border: Border.all()),
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
          '展示',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<TenjiDetailData> tenjiDataList = TenjiData.tenjiDataList;
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
                itemCount: tenjiDataList.length,
                itemBuilder: (context, index) {
                  return _buildTenjiCard(context, tenjiDataList[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
