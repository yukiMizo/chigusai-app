import 'package:chigusai_app/providers/login_data_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/main_drawer.dart';

import '../notification/notification_screen.dart';

import 'taiikusai_detail_screen.dart';

import '../../data/taiikusai_data.dart';

import 'package:chigusai_app/data/time_data.dart';

import 'result_screen.dart';

class TaiikusaiScreen extends ConsumerStatefulWidget {
  static const routeName = "/taiikusai-screen";
  const TaiikusaiScreen({super.key});

  @override
  ConsumerState<TaiikusaiScreen> createState() => _TaiikusaiScreenState();
}

class _TaiikusaiScreenState extends ConsumerState<TaiikusaiScreen> {
  final Map<String, Map<String, dynamic>> _loadedTimeMap = {};
  List<TaiikusaiDetailData> _taiikusaiDataList = [];

  Widget _buildTaiikusaiCard(BuildContext context, TaiikusaiDetailData taiikusaiDetailData) {
    final Map? time = _loadedTimeMap[taiikusaiDetailData.title];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: taiikusaiDetailData.info == null ? 10 : 0),
      child: Card(
        elevation: taiikusaiDetailData.info == null ? 0.25 : null,
        child: ListTile(
          onTap: taiikusaiDetailData.info == null ? null : () => Navigator.of(context).pushNamed(TaiikusaiDetailScreen.routeName, arguments: taiikusaiDetailData),
          onLongPress: ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.loggedInAdmin
              ? () => showDialog(
                    context: context,
                    builder: (_) {
                      return _updateTimeDialog(taiikusaiDetailData.title);
                    },
                  )
              : null,
          leading: Text(
            time == null ? taiikusaiDetailData.startTime.getTimeAsString() : Time(day: GakusaiDay.taiikusai, hour: time["hour"], minute: time["minute"]).getTimeAsString(),
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            taiikusaiDetailData.title,
            style: const TextStyle(fontSize: 20),
          ),
          trailing: taiikusaiDetailData.info == null ? null : const Icon(Icons.arrow_forward, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Text(
          '体育祭',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future _loadData() async {
    await FirebaseFirestore.instance.collection("taiikusaiTime").doc("taiikusaiTimeDoc").get().then((DocumentSnapshot doc) {
      Map data = doc.data() as Map;
      data.forEach((title, timeMap) {
        if (title == "day") {
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

  Widget _showTime(DateTime dateTime) {
    return Text(
      Time(day: GakusaiDay.taiikusai, hour: dateTime.hour, minute: dateTime.minute).getTimeAsString(),
      style: const TextStyle(fontSize: 50),
    );
  }

  Widget _updateTimeDialog(String title) {
    bool dialogIsLoading = false;
    final DateTime currentTime = DateTime(2023, 9, 6, _loadedTimeMap[title]!["hour"], _loadedTimeMap[title]!["minute"]);
    DateTime newTime = currentTime;
    return StatefulBuilder(
      builder: (context, setStateInDialog) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: Text("$title　時間変更"),
          content: SizedBox(
            height: 150,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _showTime(newTime),
                  IconButton(
                    onPressed: () async {
                      DateTime? selectedTime = await picker.DatePicker.showTimePicker(
                        context,
                        showTitleActions: true,
                        showSecondsColumn: false,
                        currentTime: newTime,
                        locale: picker.LocaleType.jp,
                      );
                      if (selectedTime == null) {
                        return;
                      }
                      setStateInDialog(() {
                        newTime = selectedTime;
                      });
                    },
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            dialogIsLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: 140,
                    height: 40,
                    child: FilledButton(
                      onPressed: newTime == currentTime
                          ? null
                          : () async {
                              setStateInDialog(() {
                                dialogIsLoading = true;
                              });
                              await FirebaseFirestore.instance.collection("taiikusaiTime").doc("taiikusaiTimeDoc").set({
                                title: {"hour": newTime.hour, "minute": newTime.minute}
                              }, SetOptions(merge: true));
                              setState(() {
                                _loadedTimeMap[title] = {"hour": newTime.hour, "minute": newTime.minute};
                              });
                              try {
                                _taiikusaiDataList.sort(((a, b) => (_loadedTimeMap[a.title]!["hour"] * 100 + _loadedTimeMap[a.title]!["minute"])
                                    .compareTo((_loadedTimeMap[b.title]!["hour"] * 100 + _loadedTimeMap[b.title]!["minute"]))));
                              } catch (_) {}
                              if (!mounted) return;
                              Navigator.pop(context);
                            },
                      child: const Text("変更"),
                    ),
                  ),
          ],
        );
      },
    );
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
      appBar: AppBar(
        title: const Text("体育祭"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          //_loadData();
          /*   await FirebaseFirestore.instance.collection("taiikusaiTime").doc("taiikusaiTimeDoc").set({
            "開会式": {"hour": 8, "minute": 45},
            "大玉転がし": {"hour": 9, "minute": 20},
            "玉入れ": {"hour": 9, "minute": 50},
            "棒引き": {"hour": 10, "minute": 20},
            "騎馬戦": {"hour": 10, "minute": 50},
            "障害物競走": {"hour": 11, "minute": 25},
            "昼休憩": {"hour": 12, "minute": 0},
            "マジクラ": {"hour": 12, "minute": 55},
            "ブロパフォ": {"hour": 13, "minute": 15},
            "ブロリレ": {"hour": 13, "minute": 45},
            "閉会式": {"hour": 14, "minute": 15},
          }, SetOptions(merge: true));*/
        },
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  _buildHeader(),
                  if (ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.loggedInAdmin) const Text("※長押しで時間を変更できます"),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _taiikusaiDataList.length,
                    itemBuilder: (context, index) {
                      return _buildTaiikusaiCard(context, _taiikusaiDataList[index]);
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(ResultScreen.routeName),
        child: const Icon(Icons.scoreboard),
      ),
    );
  }
}
