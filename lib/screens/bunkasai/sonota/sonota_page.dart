import 'package:flutter/material.dart';

import 'package:chigusai_app/data/bunkasai/sonota_data.dart';

class SonotaPage extends StatelessWidget {
  const SonotaPage({super.key});

  Widget _buildEventMerchandiseCard(BuildContext context, EventMerchandiseDetailData eventMerchandiseDetailData) {
    return Card(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 90,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(eventMerchandiseDetailData.imgPath),
          ),
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
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                  crossAxisCount: 2,
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
