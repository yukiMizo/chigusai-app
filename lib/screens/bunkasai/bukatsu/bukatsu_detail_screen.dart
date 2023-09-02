import 'package:flutter/material.dart';

import 'package:chigusai_app/widgets/image_viewer.dart';

import '../../../data/bunkasai/bukatsu_data.dart';

class BukatsuDetailScreen extends StatelessWidget {
  static const routeName = "/bukatsu-detail-screen";
  const BukatsuDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bukatsuDetailData = ModalRoute.of(context)!.settings.arguments as BukatsuDetailData;
    return Scaffold(
      appBar: AppBar(title: const Text("企画詳細")),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ImageViewer(imgPath: bukatsuDetailData.imgPath),
          const SizedBox(height: 20),
          Text(
            bukatsuDetailData.club,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(bukatsuDetailData.place),
          const SizedBox(height: 30),
          Text(bukatsuDetailData.pr),
          // FilledButton(onPressed: () {}, child: const Text("マップ")),
        ]),
      ),
    );
  }
}
