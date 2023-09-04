import 'package:flutter/material.dart';

import 'package:chigusai_app/widgets/main_drawer.dart';
import '../notification/notification_screen.dart';

class MapScreen extends StatelessWidget {
  static const routeName = "/map-screen";
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("マップ"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NotificationScreen.routeName),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: InteractiveViewer(
        child: Center(child: Image.asset("assets/images/map.jpg")),
      ),
    );
  }
}
