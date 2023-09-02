import 'package:flutter/material.dart';

import 'package:chigusai_app/widgets/image_viewer.dart';

import '../../../data/bunkasai/tenji_data.dart';

class TenjiDetailScreen extends StatelessWidget {
  static const routeName = "/tenji-detail-screen";
  const TenjiDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tenjiDetailData = ModalRoute.of(context)!.settings.arguments as TenjiDetailData;
    return Scaffold(
      appBar: AppBar(title: const Text("展示詳細")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ImageViewer(imgPath: tenjiDetailData.imgPath),
            const SizedBox(height: 20),
            Text(
              "${tenjiDetailData.hr}「${tenjiDetailData.title}」",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              tenjiDetailData.pr,
              style: const TextStyle(fontSize: 18),
            ),
            //  FilledButton(onPressed: () {}, child: const Text("マップ")),
          ]),
        ),
      ),
    );
  }
}
