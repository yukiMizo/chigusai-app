import 'package:flutter/material.dart';

import 'engeki_detail_screen.dart';

import 'package:chigusai_app/data/bunkasai/engeki_data.dart';

class EngekiPage extends StatelessWidget {
  const EngekiPage({super.key});

  Widget _buildEngekiCard(BuildContext context, EngekiDetailData engekiDetailData) {
    final String infoString = "${engekiDetailData.startTime.getDayAsString()} ${engekiDetailData.startTime.getTimeAsString()} 開演";
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          onTap: () => Navigator.of(context).pushNamed(EngekiDetailScreen.routeName, arguments: engekiDetailData),
          leading: Container(
            width: 100,
            height: 60,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(engekiDetailData.imgPath),
          ),
          title: Text(
            "${engekiDetailData.hr}「${engekiDetailData.title}」",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(infoString),
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
          '演劇',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<EngekiDetailData> engekiDataList = EngekiData.engekiDataList;
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
                itemCount: engekiDataList.length,
                itemBuilder: (context, index) {
                  return _buildEngekiCard(context, engekiDataList[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
