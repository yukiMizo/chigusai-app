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
        _loadedTimeMap[title] = timeMap;
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List<TaiikusaiDetailData> taiikusaiDataList = TaiikusaiData.taiikusaiDataList;
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
                  itemCount: taiikusaiDataList.length,
                  itemBuilder: (context, index) {
                    return TaiikusaiShiftCard(
                      taiikusaiDataList: taiikusaiDataList,
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
