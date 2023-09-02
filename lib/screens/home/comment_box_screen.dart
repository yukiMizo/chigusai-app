import 'package:flutter/material.dart';

class CommentBoxScreen extends StatelessWidget {
  static const routeName = "/comment-box-screen";
  const CommentBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("感想BOX")),
    );
  }
}
