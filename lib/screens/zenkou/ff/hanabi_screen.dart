import 'package:flutter/material.dart';

class HanabiScreen extends StatelessWidget {
  static const routeName = "/hanabi-screen";
  const HanabiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("観覧場所"),
      ),
      body: InteractiveViewer(
        child: Center(child: Image.asset("assets/images/zenkou/hanabi.jpg")),
      ),
    );
  }
}
