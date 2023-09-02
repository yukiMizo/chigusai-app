import 'package:flutter/material.dart';

import 'package:chigusai_app/data/bunkasai/sonota_data.dart';

class SonotaPage extends StatelessWidget {
  const SonotaPage({super.key});

  Widget _buildEventMerchandiseCard(BuildContext context, EventMerchandiseDetailData eventMerchandiseDetailData) {
    return Card(
      child: Column(
        children: [
          Image(image: AssetImage(eventMerchandiseDetailData.imgPath)),
          Text(eventMerchandiseDetailData.title),
          Text("${eventMerchandiseDetailData.price}円"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String saikoshiInfo = SonotaData.saikoshiInfo;
    const List<EventMerchandiseDetailData> eventMerchandiseList = SonotaData.eventMerchandiseList;
    const String chigumaInfo = SonotaData.chigumaInfo;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("再煌市", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 5),
              const Text(saikoshiInfo),
              const SizedBox(height: 20),
              const Text("学祭グッズ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                ),
                itemCount: eventMerchandiseList.length,
                itemBuilder: (context, index) {
                  return _buildEventMerchandiseCard(context, eventMerchandiseList[index]);
                },
              ),
              const SizedBox(height: 20),
              const Text("ちぐま", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const Text(chigumaInfo),
            ],
          ),
        ),
      ),
    );
  }
}
