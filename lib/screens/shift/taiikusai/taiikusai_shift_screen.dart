import 'package:flutter/material.dart';

import 'package:chigusai_app/data/taiikusai_data.dart';

import 'taiikusai_shift_card.dart';

class TaiikusaiShiftScreen extends StatelessWidget {
  static const routeName = "/taiikusai-shift-screen";
  const TaiikusaiShiftScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    List<TaiikusaiDetailData> taiikusaiDataList = TaiikusaiData.getTaiikusaiDataList;
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
                    return TaiikusaiShiftCard(taiikusaiDataList: taiikusaiDataList, index: index);
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
