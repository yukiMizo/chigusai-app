import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chigusai_app/data/taiikusai_data.dart';

import 'taiikusai_shift_card.dart';

class TaiikusaiShiftScreen extends StatefulWidget {
  static const routeName = "/taiikusai-shift-screen";
  const TaiikusaiShiftScreen({super.key});

  @override
  State<TaiikusaiShiftScreen> createState() => _TaiikusaiShiftScreenState();
}

class _TaiikusaiShiftScreenState extends State<TaiikusaiShiftScreen> {
  final Map<String, Map<String, dynamic>> _loadedTimeMap = {};
  List<TaiikusaiDetailData> _taiikusaiDataList = [];
  int _day = 6;

  Widget _buildHeader() {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '9/6 体育祭',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future _loadData() async {
    await FirebaseFirestore.instance.collection("taiikusaiTime").doc("taiikusaiTimeDoc").get().then((DocumentSnapshot doc) {
      Map data = doc.data() as Map;
      data.forEach((title, timeMap) {
        if (title == "day") {
          _day = timeMap;
        } else {
          _loadedTimeMap[title] = timeMap;
        }
      });
    });
    try {
      _taiikusaiDataList
          .sort(((a, b) => (_loadedTimeMap[a.title]!["hour"] * 100 + _loadedTimeMap[a.title]!["minute"]).compareTo((_loadedTimeMap[b.title]!["hour"] * 100 + _loadedTimeMap[b.title]!["minute"]))));
    } catch (_) {}
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    _taiikusaiDataList = [...TaiikusaiData.taiikusaiDataList];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("体育祭シフト")),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildHeader(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _taiikusaiDataList.length,
                  itemBuilder: (context, index) {
                    return TaiikusaiShiftCard(
                      taiikusaiDataList: _taiikusaiDataList,
                      day: _day,
                      index: index,
                      loadedTimeMap: _loadedTimeMap,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
