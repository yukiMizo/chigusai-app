import 'package:flutter/material.dart';

import 'package:chigusai_app/data/zenkokikaku/ff_data.dart';

import 'hanabi_screen.dart';

class FFScreen extends StatelessWidget {
  static const routeName = "/ff-screen";
  const FFScreen({super.key});

  Widget _buildFFCard(BuildContext context, FFDetailData ffDetailData) {
    void Function()? onTap;
    if (ffDetailData.title.contains("花火")) {
      onTap = () => Navigator.of(context).pushNamed(HanabiScreen.routeName);
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          onTap: onTap,
          leading: Text(
            ffDetailData.startTime.getTimeAsString(),
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            ffDetailData.title,
            style: const TextStyle(fontSize: 20),
          ),
          trailing: onTap != null ? const Icon(Icons.arrow_forward, color: Colors.grey) : null,
        ),
      ),
    );
  }

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
    const List<FFDetailData> ffDataList = FFData.ffDataList;
    return Scaffold(
      appBar: AppBar(title: const Text("FF")),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ffDataList.length,
                  itemBuilder: (context, index) {
                    return _buildFFCard(context, ffDataList[index]);
                  },
                ),
                const SizedBox(height: 100),
                const SizedBox(width: double.infinity, child: Text("マイムマイム隊形図", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () => _showImage(context, "assets/images/zenkou/mime.jpg"),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3))),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset("assets/images/zenkou/mime.jpg"),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
