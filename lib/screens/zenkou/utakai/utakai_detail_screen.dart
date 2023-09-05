import 'package:flutter/material.dart';

import 'package:chigusai_app/widgets/image_viewer.dart';
import 'package:chigusai_app/data/zenkokikaku/utakai_data.dart';

class UtakaiDetailScreen extends StatelessWidget {
  static const routeName = "/utakai-detail-screen";
  const UtakaiDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final utakaiDetailData = ModalRoute.of(context)!.settings.arguments as UtakaiDetailData;
    return Scaffold(
      appBar: AppBar(title: const Text("バンド詳細")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ImageViewer(imgPath: utakaiDetailData.imgPath),
            const SizedBox(height: 20),
            Text(
              utakaiDetailData.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(utakaiDetailData.pr),
            const SizedBox(height: 100),
          ]),
        ),
      ),
    );
  }
}
