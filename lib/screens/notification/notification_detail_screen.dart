import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'notification_screen.dart';

class NotificationDetailScreen extends StatelessWidget {
  static const routeName = "/notification-detail-screen";

  const NotificationDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    NotificationDataToPass gotData = ModalRoute.of(context)!.settings.arguments as NotificationDataToPass;
    final Map data = gotData.data;
    final int index = gotData.index;

    return Scaffold(
      appBar: AppBar(title: const Text("通知詳細")),
      body: SizedBox(
        width: double.infinity,
        child: Hero(
          tag: "notification-tag$index",
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["title"],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy/MM/dd HH:mm').format(data["timeStamp"]),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data["content"],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
