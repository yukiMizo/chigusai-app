import 'package:flutter/material.dart';

import 'package:chigusai_app/data/zenkokikaku/sanbon_data.dart';

class UtakaiScreen extends StatelessWidget {
  static const routeName = "/utakai-screen";
  const UtakaiScreen({super.key});

  Widget _buildSanbonCard(BuildContext context, SanbonDetailData sanbonDetailData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
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
      appBar: AppBar(title: const Text("歌会")),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
