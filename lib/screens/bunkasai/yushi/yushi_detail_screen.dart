import 'package:flutter/material.dart';

import 'package:chigusai_app/widgets/image_viewer.dart';

import '../../../data/bunkasai/yushi_data.dart';

class YushiDetailScreen extends StatelessWidget {
  static const routeName = "/yushi-detail-screen";
  const YushiDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final yushiDetailData = ModalRoute.of(context)!.settings.arguments as YushiDetailData;
    return Scaffold(
      appBar: AppBar(title: const Text("有志詳細")),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ImageViewer(imgPath: yushiDetailData.imgPath),
              const SizedBox(height: 20),
              Text(
                yushiDetailData.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "日時：${yushiDetailData.startTime.getDayAsString()}  ${yushiDetailData.startTime.getTimeAsString()}〜",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "場所：${yushiDetailData.place}",
                style: const TextStyle(fontSize: 18),
              ),
              // FilledButton(onPressed: () {}, child: const Text("マップ")),
            ]),
          ),
        ),
      ),
    );
  }
}
