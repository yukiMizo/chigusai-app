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
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        child: Column(children: [
          ImageViewer(imgPath: tenjiDetailData.imgPath),
          const SizedBox(height: 20),
          Text(tenjiDetailData.hr),
          Text(tenjiDetailData.title),
          FilledButton(onPressed: () {}, child: const Text("マップ")),
        ]),
      ),
    );
  }
}
