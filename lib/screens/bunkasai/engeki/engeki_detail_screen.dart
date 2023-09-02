import 'package:flutter/material.dart';

import 'package:chigusai_app/widgets/image_viewer.dart';

import 'package:chigusai_app/data/bunkasai/engeki_data.dart';

class EngekiDetailScreen extends StatelessWidget {
  static const routeName = "/engeki-detail-screen";
  const EngekiDetailScreen({super.key});

  Future _showImage(BuildContext context, String imgPath) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.7),
      barrierDismissible: true,
      barrierLabel: "",
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 5,
                      child: Image.asset(imgPath),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bunkasaiDetailData = ModalRoute.of(context)!.settings.arguments as EngekiDetailData;
    return Scaffold(
      appBar: AppBar(title: const Text("演劇詳細")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ImageViewer(imgPath: bunkasaiDetailData.imgPath),
          const SizedBox(height: 20),
          Text(
            "${bunkasaiDetailData.hr}「${bunkasaiDetailData.title}」",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "${bunkasaiDetailData.startTime.getDayAsString()}  ${bunkasaiDetailData.startTime.getTimeAsString()} 〜 ${bunkasaiDetailData.endTime.getTimeAsString()}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(
            bunkasaiDetailData.pr,
            style: const TextStyle(fontSize: 18),
          ),
          FilledButton(onPressed: () => _showImage(context, bunkasaiDetailData.soukanImgPath), child: const Text("相関図")),
          FilledButton(onPressed: () {}, child: const Text("マップ")),
        ]),
      ),
    );
  }
}
