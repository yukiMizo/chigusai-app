import 'package:flutter/material.dart';

class FFScreen extends StatelessWidget {
  static const routeName = "/ff-screen";
  const FFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FF")),
    );
  }
}
