import 'package:flutter/material.dart';

import 'package:chigusai_app/themes/app_color.dart';

import 'package:chigusai_app/data/taiikusai_data.dart';

import 'package:chigusai_app/data/time_data.dart';

import '../../../local_data.dart';
import '../../../notification_manager.dart';

enum NotifyType { noNotify, shift, player }

class TaiikusaiShiftCard extends StatefulWidget {
  final List<TaiikusaiDetailData> taiikusaiDataList;
  final int day;
  final int index;
  final Map<String, Map<String, dynamic>> loadedTimeMap;
  const TaiikusaiShiftCard({
    super.key,
    required this.loadedTimeMap,
    required this.day,
    required this.taiikusaiDataList,
    required this.index,
  });

  @override
  State<TaiikusaiShiftCard> createState() => _TaiikusaiShiftCardState();
}

class _TaiikusaiShiftCardState extends State<TaiikusaiShiftCard> {
  NotifyType _notifyType = NotifyType.noNotify;

  @override
  void initState() {
    super.initState();
    readNotify().then((value) {
      setState(() {
        _notifyType = value;
      });
    });
  }

  String get _getId {
    return "notify-${widget.taiikusaiDataList[widget.index].title}";
  }

  //通知on,offの再読み込み
  Future<NotifyType> readNotify() async {
    NotifyType notifyType = NotifyType.values.byName(await LocalData.readLocalData<String>(_getId) ?? NotifyType.noNotify.name);
    return Future<NotifyType>.value(notifyType);
  }

  Future<void> _updateLocalData() async {
    await LocalData.saveLocalData<String>(_getId, _notifyType.name);
  }

  Future<void> _setLocalNotification() async {
    late int indexToGet;
    late String message;
    if (_notifyType == NotifyType.noNotify) {
      return;
    } else if (_notifyType == NotifyType.shift) {
      indexToGet = widget.index - 1;
      message = "${widget.taiikusaiDataList[widget.index].title}の1種目前です";
    } else if (_notifyType == NotifyType.player) {
      indexToGet = widget.index - 2;
      message = "${widget.taiikusaiDataList[widget.index].title}の2種目前です";
    }
    final int hour = widget.taiikusaiDataList[indexToGet].startTime.hour;
    final int minute = widget.taiikusaiDataList[indexToGet].startTime.minute;
    await NotificationManager.registerLocNotification(
      id: _getId,
      day: widget.day,
      hour: hour,
      minute: minute,
      title: "シフト",
      message: message,
    );
  }

  Widget _dialog() {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: const Text("通知のタイミング", textAlign: TextAlign.center),
      content: SizedBox(
        height: 180,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            const Text("シフト：１種目前", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            if (widget.index > 1) const Text("　出場：２種目前", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.themeColor, width: 2)),
                onPressed: () {
                  setState(() {
                    _notifyType = NotifyType.shift;
                  });
                  _updateLocalData();
                  _setLocalNotification();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1500),
                      content: Text("通知オン　1種目前に通知します"),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text("シフト"),
              ),
            ),
            if (widget.index > 1)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.themeColor, width: 2)),
                  onPressed: () {
                    setState(() {
                      _notifyType = NotifyType.player;
                    });
                    _updateLocalData();
                    _setLocalNotification();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1500),
                        content: Text("通知オン　2種目前に通知します"),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("出場"),
                ),
              ),
          ]),
        ),
      ),
    );
  }

  Widget _buildNotifyButton() {
    return FittedBox(
      child: TextButton(
        onPressed: () {
          if (_notifyType == NotifyType.noNotify) {
            showDialog(
              context: context,
              builder: (_) {
                return _dialog();
              },
            );
          } else {
            setState(() {
              _notifyType = NotifyType.noNotify;
            });
            _updateLocalData();
            NotificationManager.cancelLocNotification(_getId);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(duration: Duration(milliseconds: 1500), content: Text("通知オフ")),
            );
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 5),
            Icon(
              Icons.notifications,
              size: 28,
              color: _notifyType != NotifyType.noNotify ? Theme.of(context).colorScheme.secondary : Colors.grey,
            ),
            Text(
              switch (_notifyType) {
                NotifyType.noNotify => "オフ",
                NotifyType.player => "出場",
                NotifyType.shift => "シフト",
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: _notifyType != NotifyType.noNotify ? Theme.of(context).colorScheme.secondary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map? time = widget.loadedTimeMap[widget.taiikusaiDataList[widget.index].title];
    return Card(
      child: ListTile(
        leading: Text(
          time == null ? widget.taiikusaiDataList[widget.index].startTime.getTimeAsString() : Time(day: GakusaiDay.taiikusai, hour: time["hour"], minute: time["minute"]).getTimeAsString(),
          style: const TextStyle(fontSize: 20),
        ),
        title: Text(
          widget.taiikusaiDataList[widget.index].title,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: widget.index != 0 ? _buildNotifyButton() : null,
      ),
    );
  }
}
