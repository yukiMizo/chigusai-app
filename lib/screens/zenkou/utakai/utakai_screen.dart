import 'package:flutter/material.dart';

import 'package:chigusai_app/data/zenkokikaku/utakai_data.dart';

import 'utakai_detail_screen.dart';

class UtakaiScreen extends StatelessWidget {
  static const routeName = "/utakai-screen";
  const UtakaiScreen({super.key});

  Widget _buildSanbonCard(BuildContext context, UtakaiDetailData utakaiDetailData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          onTap: () => Navigator.of(context).pushNamed(UtakaiDetailScreen.routeName, arguments: utakaiDetailData),
          title: Text(
            utakaiDetailData.title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<UtakaiDetailData> utakaiDataList = UtakaiData.utakaiDataList;
    return Scaffold(
      appBar: AppBar(title: const Text("歌会")),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: utakaiDataList.length,
              itemBuilder: (context, index) {
                return _buildSanbonCard(context, utakaiDataList[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
