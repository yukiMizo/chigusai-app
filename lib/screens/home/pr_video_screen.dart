import 'package:flutter/material.dart';

class PRVideoScreen extends StatelessWidget {
  static const routeName = "/pr-video-screen";
  const PRVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PR動画")),
    );
  }
}
