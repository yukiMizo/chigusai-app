import 'package:flutter/material.dart';

import 'package:chigusai_app/data/zenkokikaku/sanbon_data.dart';
import 'sanbon_detail_screen.dart';

class SabbonScreen extends StatelessWidget {
  static const routeName = "/sanbon-screen";
  const SabbonScreen({super.key});

  Widget _buildSanbonCard(BuildContext context, SanbonDetailData sanbonDetailData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          onTap: () => Navigator.of(context).pushNamed(SanbonDetailScreen.routeName, arguments: sanbonDetailData),
          leading: Container(
            width: 100,
            height: 60,
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage(sanbonDetailData.imgPath))),
          ),
          title: Text(
            sanbonDetailData.title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<SanbonDetailData> sanbonDataList = SanbonData.sanbonDataList;
    return Scaffold(
      appBar: AppBar(title: const Text("三本立て")),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: sanbonDataList.length,
              itemBuilder: (context, index) {
                return _buildSanbonCard(context, sanbonDataList[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
