import 'package:flutter/material.dart';

import 'package:chigusai_app/data/taiikusai_data.dart';

class TaiikusaiDetailScreen extends StatelessWidget {
  static const routeName = "/taiikusai-detail-screen";
  const TaiikusaiDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taiikusaiDetailData = ModalRoute.of(context)!.settings.arguments as TaiikusaiDetailData;
    return Scaffold(
      appBar: AppBar(title: const Text("競技詳細")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            taiikusaiDetailData.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Text(taiikusaiDetailData.info!),
        ]),
      ),
    );
  }
}
