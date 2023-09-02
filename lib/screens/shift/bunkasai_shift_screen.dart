import 'dart:convert';

import 'package:chigusai_app/local_data.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;

import '../../notification_manager.dart';

import 'package:chigusai_app/data/time_data.dart';

enum NotifyTime { five, ten, fifteen, twenty }

class BunkasaiShiftData {
  final String id;
  String title;
  Time startTime;
  Time endTime;
  Time notificationTime;
  Color color;

  BunkasaiShiftData({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.notificationTime,
  });

  void updateData({
    String? title,
    Time? startTime,
    Time? endTime,
    Time? notificationTime,
    Color? color,
  }) {
    if (title != null) {
      this.title = title;
    }
    if (startTime != null) {
      this.startTime = startTime;
    }
    if (endTime != null) {
      this.endTime = endTime;
    }
    if (notificationTime != null) {
      this.notificationTime = notificationTime;
    }
    if (color != null) {
      this.color = color;
    }
  }

  Map bunkasaiShiftDataMapForLocalData() {
    return {
      "id": id,
      "title": title,
      "startTimeHour": startTime.hour,
      "startTimeMinute": startTime.minute,
      "endTimeHour": endTime.hour,
      "endTimeMinute": endTime.minute,
      "color": color.value.toRadixString(16),
      "notificationTimeHour": notificationTime.hour,
      "notificationTimeMinute": notificationTime.minute,
    };
  }
}

class BunkasaiShiftScreen extends StatefulWidget {
  static const routeName = "/bunkasai-shift-screen";
  const BunkasaiShiftScreen({super.key});

  @override
  State<BunkasaiShiftScreen> createState() => _BunkasaiShiftScreenState();
}

class _BunkasaiShiftScreenState extends State<BunkasaiShiftScreen> {
  bool _isLoading = false;
  bool _isIsInit = true;
  //dialog 関係
  final TextEditingController _titleController = TextEditingController();
  late DateTime _startTime;
  late DateTime _endTime;
  NotifyTime _selectedNotifyTime = NotifyTime.ten;
  int _selectedColorIndex = 0;

  late int _day;
  late GakusaiDay _bunkasaiDay;

  final List<Color> _colors = [
    const Color(0xff2196f3),
    const Color(0xff4caf50),
    const Color(0xfff44336),
    const Color(0xffff9800),
    const Color(0xffffeb3b),
  ];
  final List<BunkasaiShiftData> _bunkasaiShiftDataList = [];

  Widget _buildShitCard(BuildContext context, BunkasaiShiftData bunkasaiShiftData) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      child: Container(
        decoration: BoxDecoration(border: Border(left: BorderSide(color: bunkasaiShiftData.color, width: 5))),
        child: ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (_) {
              return _updateDialog(bunkasaiShiftData);
            },
          ),
          leading: Text(
            bunkasaiShiftData.startTime.getTimeAsString(),
            style: const TextStyle(fontSize: 20),
          ),
          title: Text(
            bunkasaiShiftData.title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _bunkasaiDay == GakusaiDay.bunkasai1 ? '9/9 文化祭1日目' : '9/10 文化祭2日目',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String _dateTimeToString(DateTime dateTime) {
    final String hour = dateTime.hour.toString();
    late String minute;
    if (dateTime.minute < 10) {
      minute = "0${dateTime.minute}";
    } else {
      minute = dateTime.minute.toString();
    }
    return "$hour:$minute";
  }

//add shift data 関連
  void _initDialogData() {
    _titleController.text = "";
    _selectedNotifyTime = NotifyTime.ten;
    _startTime = DateTime.now();
    _endTime = DateTime.now().add(const Duration(hours: 1));
    _selectedColorIndex = 0;
  }

  Widget _colorButton(int index, void Function(void Function()) setStateInDialog) {
    bool selected = false;
    if (_selectedColorIndex == index) {
      selected = true;
    }
    return InkWell(
      onTap: () {
        setStateInDialog(() {
          _selectedColorIndex = index;
        });
      },
      child: Card(
        elevation: selected ? 3 : 0,
        shadowColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: selected ? Colors.deepPurple : Colors.grey, width: 3),
            color: _colors[index],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _addDialog() {
    bool dialogIsLoading = false;
    _initDialogData();
    return StatefulBuilder(
      builder: (context, setStateInDialog) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: const Text("追加"),
          content: SizedBox(
            height: 320,
            width: 200,
            child: dialogIsLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(label: Text("タイトル")),
                          onChanged: (_) {
                            setStateInDialog(() {});
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text("開始", style: TextStyle(fontSize: 22)),
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                onPressed: () async {
                                  DateTime? selectedTime = await picker.DatePicker.showTimePicker(
                                    context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    currentTime: _startTime,
                                    locale: picker.LocaleType.jp,
                                  );
                                  if (selectedTime == null) {
                                    return;
                                  }
                                  setStateInDialog(() {
                                    _startTime = selectedTime;
                                  });
                                },
                                child: Text(_dateTimeToString(_startTime), style: const TextStyle(fontSize: 22)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("終了", style: TextStyle(fontSize: 22)),
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                onPressed: () async {
                                  DateTime? selectedTime = await picker.DatePicker.showTimePicker(
                                    context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    currentTime: _endTime,
                                    locale: picker.LocaleType.jp,
                                  );
                                  if (selectedTime == null) {
                                    return;
                                  }
                                  setStateInDialog(() {
                                    _endTime = selectedTime;
                                  });
                                },
                                child: Text(_dateTimeToString(_endTime), style: const TextStyle(fontSize: 22)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            const Icon(Icons.schedule),
                            const SizedBox(width: 20),
                            DropdownButton(
                              items: const [
                                DropdownMenuItem(
                                  value: NotifyTime.five,
                                  child: Text("5分前", style: TextStyle(fontSize: 20)),
                                ),
                                DropdownMenuItem(
                                  value: NotifyTime.ten,
                                  child: Text("10分前", style: TextStyle(fontSize: 20)),
                                ),
                                DropdownMenuItem(
                                  value: NotifyTime.fifteen,
                                  child: Text("15分前", style: TextStyle(fontSize: 20)),
                                ),
                                DropdownMenuItem(
                                  value: NotifyTime.twenty,
                                  child: Text("20分前", style: TextStyle(fontSize: 20)),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setStateInDialog(() {
                                  _selectedNotifyTime = value;
                                });
                              },
                              value: _selectedNotifyTime,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text("カラー", style: TextStyle(fontSize: 22)),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            _colorButton(0, setStateInDialog),
                            const SizedBox(width: 8),
                            _colorButton(1, setStateInDialog),
                            const SizedBox(width: 8),
                            _colorButton(2, setStateInDialog),
                            const SizedBox(width: 8),
                            _colorButton(3, setStateInDialog),
                            const SizedBox(width: 8),
                            _colorButton(4, setStateInDialog),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            if (!dialogIsLoading)
              SizedBox(
                width: 140,
                height: 40,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("キャンセル"),
                ),
              ),
            if (!dialogIsLoading)
              SizedBox(
                width: 140,
                height: 40,
                child: FilledButton(
                  onPressed: _titleController.text == ""
                      ? null
                      : () async {
                          setStateInDialog(() {
                            dialogIsLoading = true;
                          });
                          final int notificationTime = switch (_selectedNotifyTime) {
                            NotifyTime.five => 5,
                            NotifyTime.ten => 10,
                            NotifyTime.fifteen => 15,
                            NotifyTime.twenty => 20,
                          };
                          final String id = DateTime.now().toIso8601String();
                          final BunkasaiShiftData bunkasaiShiftDataToAdd = BunkasaiShiftData(
                            id: id,
                            title: _titleController.text,
                            startTime: Time(day: _bunkasaiDay, hour: _startTime.hour, minute: _startTime.minute),
                            endTime: Time(day: _bunkasaiDay, hour: _endTime.hour, minute: _endTime.minute),
                            color: _colors[_selectedColorIndex],
                            notificationTime: Time(day: _bunkasaiDay, hour: _startTime.hour, minute: _startTime.minute - notificationTime),
                          );
                          setState(() {
                            _bunkasaiShiftDataList.add(bunkasaiShiftDataToAdd);
                          });

                          //local data に追加
                          final String dataName = "bunkasai-shift-list-$_day";
                          final List<String> bunkasaiShiftList = await LocalData.readLocalData<List>(
                                dataName,
                              ) ??
                              [];
                          final String jsonBunkasaiShiftData = jsonEncode(bunkasaiShiftDataToAdd.bunkasaiShiftDataMapForLocalData());
                          bunkasaiShiftList.add(jsonBunkasaiShiftData);
                          await LocalData.saveLocalData<List>(dataName, bunkasaiShiftList);

                          //local 通知を設定
                          await NotificationManager.registerLocNotification(
                            id: id,
                            day: _day,
                            hour: _startTime.hour,
                            minute: _startTime.minute - notificationTime,
                            title: "シフト",
                            message: "${_titleController.text}の$notificationTime分前です",
                          );
                          if (!mounted) return;
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

//update shift data 関連
  void _setDialogData(BunkasaiShiftData bunkasaiShiftData) {
    _titleController.text = bunkasaiShiftData.title;
    final int timeBeforeNotify = bunkasaiShiftData.startTime.minute - bunkasaiShiftData.notificationTime.minute;
    _selectedNotifyTime = switch (timeBeforeNotify) {
      5 => NotifyTime.five,
      10 => NotifyTime.ten,
      15 => NotifyTime.fifteen,
      20 => NotifyTime.twenty,
      int() => NotifyTime.ten,
    };
    _startTime = DateTime(2023, 9, _day, bunkasaiShiftData.startTime.hour, bunkasaiShiftData.startTime.minute);
    _endTime = DateTime(2023, 9, _day, bunkasaiShiftData.endTime.hour, bunkasaiShiftData.endTime.minute);
    _selectedColorIndex = _colors.indexOf(bunkasaiShiftData.color);
  }

  Widget _updateDialog(BunkasaiShiftData bunkasaiShiftData) {
    bool dialogIsLoading = false;
    _setDialogData(bunkasaiShiftData);
    return StatefulBuilder(
      builder: (context, setStateInDialog) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: const Text("編集"),
          content: SizedBox(
            height: 320,
            width: 200,
            child: dialogIsLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(label: Text("タイトル")),
                          onChanged: (_) {
                            setStateInDialog(() {});
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text("開始", style: TextStyle(fontSize: 22)),
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                onPressed: () async {
                                  DateTime? selectedTime = await picker.DatePicker.showTimePicker(
                                    context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    currentTime: _startTime,
                                    locale: picker.LocaleType.jp,
                                  );
                                  if (selectedTime == null) {
                                    return;
                                  }
                                  setStateInDialog(() {
                                    _startTime = selectedTime;
                                  });
                                },
                                child: Text(_dateTimeToString(_startTime), style: const TextStyle(fontSize: 22)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("終了", style: TextStyle(fontSize: 22)),
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                onPressed: () async {
                                  DateTime? selectedTime = await picker.DatePicker.showTimePicker(
                                    context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    currentTime: _endTime,
                                    locale: picker.LocaleType.jp,
                                  );
                                  if (selectedTime == null) {
                                    return;
                                  }
                                  setStateInDialog(() {
                                    _endTime = selectedTime;
                                  });
                                },
                                child: Text(_dateTimeToString(_endTime), style: const TextStyle(fontSize: 22)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            const Icon(Icons.schedule),
                            const SizedBox(width: 20),
                            DropdownButton(
                              items: const [
                                DropdownMenuItem(
                                  value: NotifyTime.five,
                                  child: Text("5分前", style: TextStyle(fontSize: 20)),
                                ),
                                DropdownMenuItem(
                                  value: NotifyTime.ten,
                                  child: Text("10分前", style: TextStyle(fontSize: 20)),
                                ),
                                DropdownMenuItem(
                                  value: NotifyTime.fifteen,
                                  child: Text("15分前", style: TextStyle(fontSize: 20)),
                                ),
                                DropdownMenuItem(
                                  value: NotifyTime.twenty,
                                  child: Text("20分前", style: TextStyle(fontSize: 20)),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setStateInDialog(() {
                                  _selectedNotifyTime = value;
                                });
                              },
                              value: _selectedNotifyTime,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text("カラー", style: TextStyle(fontSize: 22)),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            _colorButton(0, setStateInDialog),
                            const SizedBox(width: 8),
                            _colorButton(1, setStateInDialog),
                            const SizedBox(width: 8),
                            _colorButton(2, setStateInDialog),
                            const SizedBox(width: 8),
                            _colorButton(3, setStateInDialog),
                            const SizedBox(width: 8),
                            _colorButton(4, setStateInDialog),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            if (!dialogIsLoading)
              SizedBox(
                width: 140,
                height: 40,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("キャンセル"),
                ),
              ),
            if (!dialogIsLoading)
              SizedBox(
                width: 140,
                height: 40,
                child: FilledButton(
                  onPressed: _titleController.text == ""
                      ? null
                      : () async {
                          setStateInDialog(() {
                            dialogIsLoading = true;
                          });
                          final int notificationTime = switch (_selectedNotifyTime) {
                            NotifyTime.five => 5,
                            NotifyTime.ten => 10,
                            NotifyTime.fifteen => 15,
                            NotifyTime.twenty => 20,
                          };
                          final BunkasaiShiftData bunkasaiShiftDataToUpdate = _bunkasaiShiftDataList[_bunkasaiShiftDataList.indexOf(bunkasaiShiftData)];
                          setState(() {
                            bunkasaiShiftDataToUpdate.updateData(
                              title: _titleController.text,
                              startTime: Time(day: _bunkasaiDay, hour: _startTime.hour, minute: _startTime.minute),
                              endTime: Time(day: _bunkasaiDay, hour: _endTime.hour, minute: _endTime.minute),
                              color: _colors[_selectedColorIndex],
                              notificationTime: Time(day: _bunkasaiDay, hour: _startTime.hour, minute: _startTime.minute - notificationTime),
                            );
                          });
                          final String id = _bunkasaiShiftDataList[_bunkasaiShiftDataList.indexOf(bunkasaiShiftData)].id;
                          //local data を更新
                          final String dataName = "bunkasai-shift-list-$_day";
                          final List<String> bunkasaiShiftList = await LocalData.readLocalData<List>(
                                dataName,
                              ) ??
                              [];
                          bunkasaiShiftList.removeWhere((data) => json.decode(data)["id"] == id);
                          final String jsonBunkasaiShiftData = jsonEncode(bunkasaiShiftDataToUpdate.bunkasaiShiftDataMapForLocalData());
                          bunkasaiShiftList.add(jsonBunkasaiShiftData);
                          await LocalData.saveLocalData<List>(dataName, bunkasaiShiftList);

                          //local 通知設定
                          await NotificationManager.cancelLocNotification(id);
                          await NotificationManager.registerLocNotification(
                            id: id,
                            day: _day,
                            hour: _startTime.hour,
                            minute: _startTime.minute - notificationTime,
                            title: "シフト",
                            message: "${_titleController.text}の$notificationTime分前です",
                          );
                          if (!mounted) return;
                          Navigator.pop(context);
                        },
                  child: const Text("更新"),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    final String dataName = "bunkasai-shift-list-$_day";
    final List<String> bunkasaiShiftList = await LocalData.readLocalData<List>(
          dataName,
        ) ??
        [];
    for (var jsonData in bunkasaiShiftList) {
      final data = json.decode(jsonData);
      _bunkasaiShiftDataList.add(BunkasaiShiftData(
        id: data["id"],
        title: data["title"],
        startTime: Time(day: _bunkasaiDay, hour: data["startTimeHour"], minute: data["startTimeMinute"]),
        endTime: Time(day: _bunkasaiDay, hour: data["endTimeHour"], minute: data["endTimeMinute"]),
        color: Color(int.parse(data["color"], radix: 16)),
        notificationTime: Time(day: _bunkasaiDay, hour: data["notificationTimeHour"], minute: data["notificationTimeMinute"]),
      ));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _bunkasaiDay = ModalRoute.of(context)!.settings.arguments as GakusaiDay;
    if (_bunkasaiDay == GakusaiDay.bunkasai1) {
      _day = 9;
    } else {
      _day = 10;
    }
    if (_isIsInit) {
      _loadData();
      _isIsInit = false;
    }
    //sort shift data list
    _bunkasaiShiftDataList.sort(((a, b) => a.startTime.getTimeAsNumber().compareTo(b.startTime.getTimeAsNumber())));
    return Scaffold(
      appBar: AppBar(title: const Text("文化祭シフト")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Scrollbar(
              child: SingleChildScrollView(
                primary: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _buildHeader(),
                      _bunkasaiShiftDataList.isEmpty
                          ? const Text("シフトはまだありません")
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _bunkasaiShiftDataList.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: Key(_bunkasaiShiftDataList[index].id),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    color: Colors.red,
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onDismissed: (direction) async {
                                    if (direction == DismissDirection.endToStart) {
                                      final String id = _bunkasaiShiftDataList[index].id;
                                      //local data を削除
                                      final String dataName = "bunkasai-shift-list-$_day";
                                      final List<String> bunkasaiShiftList = await LocalData.readLocalData<List>(
                                            dataName,
                                          ) ??
                                          [];
                                      bunkasaiShiftList.removeWhere((data) => json.decode(data)["id"] == id);
                                      await LocalData.saveLocalData<List>(dataName, bunkasaiShiftList);
                                      //local 通知の設定
                                      NotificationManager.cancelLocNotification(id);
                                      setState(() {
                                        _bunkasaiShiftDataList.removeAt(index);
                                      });
                                    }
                                  },
                                  child: _buildShitCard(context, _bunkasaiShiftDataList[index]),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
                context: context,
                builder: (_) {
                  return _addDialog();
                },
              ),
          child: const Icon(Icons.add)),
    );
  }
}
