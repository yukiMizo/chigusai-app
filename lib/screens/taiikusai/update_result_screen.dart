import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'result_screen.dart';

import 'package:chigusai_app/data/taiikusai_data.dart';

import 'package:chigusai_app/data/time_data.dart';

class UpdateResultScreen extends StatefulWidget {
  static const routeName = "/update-result-screen";
  const UpdateResultScreen({super.key});

  @override
  State<UpdateResultScreen> createState() => _UpdateResultScreenState();
}

class _UpdateResultScreenState extends State<UpdateResultScreen> {
  bool _isLoading = false;
  bool _isInit = true;
  bool _isDirty = false;

  //dialog 関連
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _pointController = TextEditingController();

  final Map<String, AwardBlockData> _awardBlockDataMap = {};

  Widget _buildRankWidget(String title, RankWidgetData data) {
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
          const SizedBox(width: 15),
          SizedBox(
            width: 55,
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
          const SizedBox(width: 15),
          IconButton(
              onPressed: () {
                _awardBlockDataMap[title]!.rankWidgetDataList.removeWhere((d) => (d.className == data.className && d.place == data.place && d.point == data.point));
                setState(() {
                  _isDirty = true;
                });
              },
              icon: const Icon(Icons.delete)),
        ]),
        const Divider(color: Colors.grey)
      ],
    );
  }

  Widget _buildEditAwardBlock(String title) {
    List<RankWidgetData> rankWidgetDataList = [...(_awardBlockDataMap[title] ?? AwardBlockData(title: title, rankWidgetDataList: [])).rankWidgetDataList];
    rankWidgetDataList.sort(((a, b) => a.place.compareTo(b.place)));
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
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
                      ? const Text("結果を入力してください")
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: rankWidgetDataList.length,
                          itemBuilder: (context, index) {
                            return _buildRankWidget(title, rankWidgetDataList[index]);
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) {
                return _addDialog(title);
              },
            ),
            icon: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _addDialog(String title) {
    _placeController.text = "";
    _classNameController.text = "";
    _pointController.text = "";
    return StatefulBuilder(
      builder: (context, setStateInDialog) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: const Text("追加"),
          content: SizedBox(
            height: 200,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _placeController,
                    decoration: const InputDecoration(label: Text("順位")),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) {
                      setStateInDialog(() {});
                    },
                  ),
                  TextField(
                    controller: _classNameController,
                    decoration: const InputDecoration(label: Text("クラス")),
                    onChanged: (_) {
                      setStateInDialog(() {});
                    },
                  ),
                  TextField(
                    controller: _pointController,
                    decoration: const InputDecoration(label: Text("点数")),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (_) {
                      setStateInDialog(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            SizedBox(
              width: 140,
              height: 40,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("キャンセル"),
              ),
            ),
            SizedBox(
              width: 140,
              height: 40,
              child: FilledButton(
                onPressed: (_placeController.text == "" || _classNameController.text == "" || _pointController.text == "")
                    ? null
                    : () {
                        if (_awardBlockDataMap[title] == null) {
                          _awardBlockDataMap[title] = AwardBlockData(title: title, rankWidgetDataList: [
                            RankWidgetData(
                              place: int.parse(_placeController.text),
                              className: _classNameController.text,
                              point: int.parse(_pointController.text),
                            ),
                          ]);
                        } else {
                          _awardBlockDataMap[title]!.rankWidgetDataList.add(RankWidgetData(
                                place: int.parse(_placeController.text),
                                className: _classNameController.text,
                                point: int.parse(_pointController.text),
                              ));
                        }
                        setState(() {
                          _isDirty = true;
                        });
                        Navigator.pop(context);
                      },
                child: const Text("追加"),
              ),
            ),
          ],
        );
      },
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

  //firestore のデータを更新
  Future _updateFirestoreData() async {
    Map<String, dynamic> dataToset = {};
    _awardBlockDataMap.forEach((title, awardBlockData) {
      final List<Map<String, dynamic>> listToAdd = [];
      for (var data in awardBlockData.rankWidgetDataList) {
        listToAdd.add({
          "place": data.place,
          "className": data.className,
          "point": data.point,
        });
      }
      dataToset[title] = listToAdd;
    });

    FirebaseFirestore.instance.collection("taiikusaiResult").doc("taiikusaiResultDoc").set(dataToset);
  }

  @override
  Widget build(BuildContext context) {
    final List<TaiikusaiDetailData> taiikusaiDataList = [...TaiikusaiData.taiikusaiDataList];
    taiikusaiDataList.removeWhere((data) => data.showResult == false);
    taiikusaiDataList.add(const TaiikusaiDetailData(
        title: "全体",
        startTime: Time(
          day: GakusaiDay.taiikusai,
          hour: 20,
        ),
        showResult: true),);
    if (_isInit) {
      _loadData();
      _isInit = false;
    }
    return Scaffold(
      appBar: AppBar(title: const Text("体育祭結果更新")),
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
                        child: _buildEditAwardBlock(taiikusaiDataList[index].title),
                      );
                    },
                  ),
                ),
              ),
            ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        SizedBox(
          width: 250,
          child: FilledButton(
            onPressed: _isDirty
                ? () async {
                    setState(() {
                      _isLoading = true;
                    });
                    _updateFirestoreData();
                    Navigator.pop(context);
                  }
                : null,
            child: const Text("更新"),
          ),
        ),
      ],
    );
  }
}
