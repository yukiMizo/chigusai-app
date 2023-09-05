import 'package:flutter/material.dart';

class MimeScreen extends StatelessWidget {
  static const routeName = "/mime-screen";
  const MimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("マイムマイム隊形図"),
      ),
      body: InteractiveViewer(
        child: Center(child: Image.asset("assets/images/zenkou/mime.jpg")),
      ),
    );
  }
}
