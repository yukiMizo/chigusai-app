import 'package:chigusai_app/providers/login_data_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'tenji_detail_screen.dart';

import 'package:chigusai_app/data/bunkasai/tenji_data.dart';

enum KomiLevel { komi1, komi2, komi3 }

class TenjiPage extends ConsumerStatefulWidget {
  const TenjiPage({super.key});

  @override
  ConsumerState<TenjiPage> createState() => _TenjiPageState();
}

class _TenjiPageState extends ConsumerState<TenjiPage> {
  final Map<String, KomiLevel> _komiLevelMap = {};
  //混み具合を表します
  Widget _buildKomiWidget({required KomiLevel komiLevel, double height = 50}) {
    final int komiNum = switch (komiLevel) {
      KomiLevel.komi1 => 1,
      KomiLevel.komi2 => 2,
      KomiLevel.komi3 => 3,
    };
    return Container(
      height: height,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      clipBehavior: Clip.antiAlias,
      child: Image.asset("assets/images/bunkasai/tenji/komi$komiNum.jpg"),
    );
  }

  Widget _buildTenjiCard(BuildContext context, TenjiDetailData tenjiDetailData) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(TenjiDetailScreen.routeName, arguments: tenjiDetailData),
        onLongPress: ref.watch(canChangeKomi)
            ? () => showDialog(
                  context: context,
                  builder: (_) {
                    return _updateKomiDialog(tenjiDetailData.hr);
                  },
                )
            : null,
        leading: Container(
          width: 100,
          height: 60,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(tenjiDetailData.imgPath),
        ),
        title: Text(tenjiDetailData.hr),
        subtitle: Text(tenjiDetailData.title, maxLines: 2),
        trailing: _buildKomiWidget(komiLevel: _komiLevelMap[tenjiDetailData.hr] ?? KomiLevel.komi1),
      ),
    );
  }

  Widget _buildHeader() {
    return const SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          '展示',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future _loadData() async {
    await FirebaseFirestore.instance.collection("tenjiKomi").doc("tenjiKomiDoc").get().then((DocumentSnapshot doc) {
      Map data = doc.data() as Map;
      data.forEach((hr, komiNum) {
        late KomiLevel komiLevelToSet;
        if (komiNum == 1) {
          komiLevelToSet = KomiLevel.komi1;
        } else if (komiNum == 2) {
          komiLevelToSet = KomiLevel.komi2;
        } else if (komiNum == 3) {
          komiLevelToSet = KomiLevel.komi3;
        } else {
          komiLevelToSet = KomiLevel.komi1;
        }
        _komiLevelMap[hr] = komiLevelToSet;
      });
    });
    setState(() {});
  }

  Widget _updateKomiDialog(String hr) {
    bool dialogIsLoading = false;
    final currentKomiLevel = _komiLevelMap[hr] ?? KomiLevel.komi1;
    KomiLevel newKomiLevel = currentKomiLevel;
    return StatefulBuilder(
      builder: (context, setStateInDialog) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: Text("$hr混み具合を変更"),
          content: SizedBox(
            height: 200,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildKomiWidget(komiLevel: newKomiLevel, height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setStateInDialog(() {
                            if (newKomiLevel == KomiLevel.komi2) {
                              newKomiLevel = KomiLevel.komi1;
                            } else if (newKomiLevel == KomiLevel.komi3) {
                              newKomiLevel = KomiLevel.komi2;
                            }
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.arrow_left,
                          size: 80,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setStateInDialog(() {
                            if (newKomiLevel == KomiLevel.komi1) {
                              newKomiLevel = KomiLevel.komi2;
                            } else if (newKomiLevel == KomiLevel.komi2) {
                              newKomiLevel = KomiLevel.komi3;
                            }
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          Icons.arrow_right,
                          size: 80,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
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
                      onPressed: currentKomiLevel == newKomiLevel
                          ? null
                          : () async {
                              setStateInDialog(() {
                                dialogIsLoading = true;
                              });
                              setState(() {
                                _komiLevelMap[hr] = newKomiLevel;
                              });
                              final int komiNum = switch (newKomiLevel) { KomiLevel.komi1 => 1, KomiLevel.komi2 => 2, KomiLevel.komi3 => 3 };
                              await FirebaseFirestore.instance.collection("tenjiKomi").doc("tenjiKomiDoc").set({hr: komiNum}, SetOptions(merge: true));
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List<TenjiDetailData> tenjiDataList = TenjiData.tenjiDataList;
    return RefreshIndicator(
      onRefresh: () async {
        _loadData();
      },
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _buildHeader(),
                if (ref.watch(canChangeKomi)) const Text("※長押しで混み具合を変更できます"),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tenjiDataList.length,
                  itemBuilder: (context, index) {
                    return _buildTenjiCard(context, tenjiDataList[index]);
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
