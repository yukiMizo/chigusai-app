import 'package:flutter/material.dart';

import 'package:chigusai_app/widgets/image_viewer.dart';

import 'package:chigusai_app/data/zenkokikaku/sanbon_data.dart';

class SanbonDetailScreen extends StatelessWidget {
  static const routeName = "/sanbon-detail-screen";
  const SanbonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sanbonDetailData = ModalRoute.of(context)!.settings.arguments as SanbonDetailData;
    return Scaffold(
      appBar: AppBar(title: const Text("三本立て詳細")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ImageViewer(imgPath: sanbonDetailData.imgPath),
            const SizedBox(height: 20),
            Text(
              sanbonDetailData.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}
