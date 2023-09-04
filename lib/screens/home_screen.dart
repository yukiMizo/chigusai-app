import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification/notification_screen.dart';

import '../widgets/main_drawer.dart';
import '../bottom_navigation.dart';

import '../providers/login_data_provider.dart';

import '../notification_manager.dart';

import 'notification/send_notification_screen.dart';

//import 'home/comment_box_screen.dart';
import 'home/map_screen.dart';
//import 'home/pr_video_screen.dart';
import 'taiikusai/result_screen.dart';
//import 'home/schedule/schedule_screen.dart';
import 'home/theme_song/theme_song_screen.dart';
import 'taiikusai/update_result_screen.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = "/home-screen";
  const HomeScreen({super.key});

  Widget _tategakiText(String text) {
    List<Widget> tategakiList = [];
    for (int i = 0; i < text.length; i++) {
      tategakiList.add(
        Text(
          text[i],
          style: const TextStyle(
            height: 1.0,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: tategakiList,
    );
  }

  Widget _eventButton({required String lable, required void Function() onPressed}) {
    return SizedBox(
      width: 80,
      height: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          foregroundColor: Colors.black,
        ),
        child: _tategakiText(lable),
      ),
    );
  }

  Widget _functionButton({required String text, required IconData icon, required void Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade200],
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              const SizedBox(width: 15),
              Icon(icon, color: Colors.white),
              const SizedBox(width: 15),
              Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Future _init(WidgetRef ref) async {
    //init login data
    LoginDataManager.setLoginDataProviderDataFromLocal(ref);
    //init local notification
    NotificationManager.initializeLocNotification();
    NotificationManager.requestPermissions();
    //handle background message
    FirebaseMessaging.onBackgroundMessage(NotificationManager.firebaseMessagingBackgroundHandler);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _init(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text("第61回千種祭"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SizedBox(width: double.infinity, child: Text('イベント', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _eventButton(
                    lable: "体育祭",
                    onPressed: () => ref.read(bottomNavigationProvider.notifier).set(1),
                  ),
                  const SizedBox(width: 20),
                  _eventButton(
                    lable: "文化祭",
                    onPressed: () => ref.read(bottomNavigationProvider.notifier).set(2),
                  ),
                  const SizedBox(width: 20),
                  _eventButton(
                    lable: "全校企画",
                    onPressed: () => ref.read(bottomNavigationProvider.notifier).set(3),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const SizedBox(width: double.infinity, child: Text('機能', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 20),
              Column(
                children: [
                  _functionButton(
                    text: "マップ",
                    icon: Icons.map,
                    onPressed: () => Navigator.of(context).pushNamed(MapScreen.routeName),
                  ),
                  const SizedBox(width: 10),
                  _functionButton(
                    text: "テーマソング",
                    icon: Icons.music_note,
                    onPressed: () => Navigator.of(context).pushNamed(ThemeSongScreen.routeName),
                  ),
                  _functionButton(
                    text: "体育祭結果",
                    icon: Icons.scoreboard,
                    onPressed: () => Navigator.of(context).pushNamed(ResultScreen.routeName),
                  ),
                  if (ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.loggedInAdmin)
                    _functionButton(
                      text: "体育祭結果更新",
                      icon: Icons.sports,
                      onPressed: () => Navigator.of(context).pushNamed(UpdateResultScreen.routeName),
                    ),if (ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.loggedInAdmin)
                    _functionButton(
                      text: "通知を送る",
                      icon: Icons.send,
                      onPressed: () => Navigator.of(context).pushNamed(SendNotificationScreen.routeName),
                    ),
                  const SizedBox(width: 10),
                  /* if (ref.watch(currentLoginStatusProvider) != CurrentLoginStatus.notLoggedIn)
                    _functionButton(
                      text: "PR動画",
                      icon: Icons.play_arrow,
                      onPressed: () => Navigator.of(context).pushNamed(PRVideoScreen.routeName),
                    )*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
