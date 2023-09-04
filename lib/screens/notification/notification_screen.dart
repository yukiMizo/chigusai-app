import 'package:chigusai_app/providers/login_data_provider.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'notification_detail_screen.dart';

class NotificationDataToPass {
  final Map data;
  final int index;

  NotificationDataToPass({
    required this.data,
    required this.index,
  });
}

class NotificationScreen extends ConsumerStatefulWidget {
  static const routeName = "/notification-screen";

  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  bool _isLoading = false;
  bool _isInit = true;
  final List<Map> _notifications = [];

  Future _loadData() async {
    setState(() {
      _isLoading = true;
    });
    var gotData = await FirebaseFirestore.instance.collection("notification").get();
    for (var data in gotData.docs) {
      final d = data.data();
      final String id = data.id;
      _notifications.add({
        "id": id,
        "timeStamp": d["timeStamp"].toDate(),
        "content": d["content"],
        "title": d["title"],
      });
    }
    _notifications.sort((a, b) => b['timeStamp'].compareTo(a['timeStamp']));
    setState(() {
      _isLoading = false;
    });
  }

  Widget _notificationWidget({
    required notificationData,
    required int index,
    bool? isLoggedInAdmin,
  }) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          NotificationDetailScreen.routeName,
          arguments: NotificationDataToPass(data: notificationData, index: index),
        ),
        child: Hero(
          tag: "notification-tag$index",
          child: Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            notificationData["title"],
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('yyyy/MM/dd HH:mm').format(notificationData["timeStamp"]),
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  if (isLoggedInAdmin == true) const Expanded(child: SizedBox()),
                  if (isLoggedInAdmin == true)
                    IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) {
                          return _dialog(notificationData: notificationData);
                        },
                      ),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dialog({required notificationData}) {
    bool dialogIsLoading = false;
    return StatefulBuilder(
      builder: (context, setStateInDialog) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: const Text("確認"),
          content: SizedBox(
            height: 200,
            width: 200,
            child: dialogIsLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(
                                notificationData["title"],
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(notificationData["content"]),
                            ]),
                          ),
                        ),
                      ),
                      const Divider(),
                      const Text(
                        "を消去します。",
                      )
                    ],
                  ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            if (!dialogIsLoading)
              SizedBox(
                width: 140,
                height: 40,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("キャンセル"),
                ),
              ),
            if (!dialogIsLoading)
              SizedBox(
                width: 140,
                height: 40,
                child: FilledButton(
                  child: const Text("消去"),
                  onPressed: () async {
                    setStateInDialog(() {
                      dialogIsLoading = true;
                    });
                    await FirebaseFirestore.instance.collection("notification").doc(notificationData["id"]).delete();
                    dialogIsLoading = false;
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('通知を消去しました。'),
                      ),
                    );
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isInit) {
      _loadData();
      _isInit = false;
    }
    return Scaffold(
      appBar: AppBar(title: const Text("通知一覧")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: (_notifications.isEmpty) ? 0 : _notifications.length + 1,
              itemBuilder: ((context, index) {
                index -= 1;
                if (index == -1) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: const Text(
                      "※タップで内容を確認できます。",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }
                return _notificationWidget(
                  notificationData: _notifications[index],
                  index: index,
                  isLoggedInAdmin: ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.loggedInAdmin,
                  // isLoggedInAdmin: isLoggedInAdmin,
                );
              }),
            ),
    );
  }
}
