import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chigusai_app/data/taiikusai_data.dart';

class RankWidgetData {
  final int place;
  final String className;
  final int point;

  const RankWidgetData({
    required this.place,
    required this.className,
    required this.point,
  });
}

class AwardBlockData {
  final String title;
  final List<RankWidgetData> rankWidgetDataList;

  const AwardBlockData({
    required this.title,
    required this.rankWidgetDataList,
  });
}

class ResultScreen extends StatefulWidget {
  static const routeName = "/result-screen";
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isLoading = false;
  bool _isInit = true;

  final Map<String, AwardBlockData> _awardBlockDataMap = {};

  Widget _buildRankWidget(RankWidgetData data) {
    return Column(
      children: [
        Row(children: [
          const SizedBox(width: 10),
          SizedBox(
            width: 50,
            child: Text(
              "${data.place}位",
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 40),
          SizedBox(
            width: 80,
            child: Text(
              data.className,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: 80,
            child: Text(
              "${data.point}点",
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 10),
        ]),
        const Divider(color: Colors.grey)
      ],
    );
  }

  Widget _buildAwardBlock(String title) {
    List<RankWidgetData> rankWidgetDataList = [...(_awardBlockDataMap[title] ?? AwardBlockData(title: title, rankWidgetDataList: [])).rankWidgetDataList];
    rankWidgetDataList.sort(((a, b) => a.place.compareTo(b.place)));
    return Card(
      color: Colors.yellow.shade50,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            rankWidgetDataList.isEmpty
                ? const Text("反映をお待ちください")
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rankWidgetDataList.length,
                    itemBuilder: (context, index) {
                      return _buildRankWidget(rankWidgetDataList[index]);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  //体育祭結果のデータを読み込み
  Future _loadData() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance.collection("taiikusaiResult").doc("taiikusaiResultDoc").get().then((DocumentSnapshot doc) {
      Map data = doc.data() as Map;
      data.forEach((title, resultList) {
        final List<RankWidgetData> rankWidgetDataList = [];
        for (var map in resultList) {
          rankWidgetDataList.add(RankWidgetData(
            place: map["place"],
            point: map["point"],
            className: map["className"],
          ));
        }
        _awardBlockDataMap[title] = AwardBlockData(title: title, rankWidgetDataList: rankWidgetDataList);
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TaiikusaiDetailData> taiikusaiDataList = [...TaiikusaiData.taiikusaiDataList];
    taiikusaiDataList.removeWhere((data) => data.showResult == false);

    if (_isInit) {
      _loadData();
      _isInit = false;
    }
    return Scaffold(
      appBar: AppBar(title: const Text("体育祭結果")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: taiikusaiDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: _buildAwardBlock(taiikusaiDataList[index].title),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
