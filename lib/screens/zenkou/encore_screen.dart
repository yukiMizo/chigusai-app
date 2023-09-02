import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:chigusai_app/themes/app_color.dart';

class EncoreScreen extends StatefulWidget {
  static const routeName = "/encore-screen";

  const EncoreScreen({super.key});

  @override
  State<EncoreScreen> createState() => _EncoreScreenState();
}

class _EncoreScreenState extends State<EncoreScreen> {
  bool _pageIsLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("アンコールステージ")),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://docs.google.com/forms/d/e/1FAIpQLSeMywwMQKdMfcu62kKY1WMvE8rgsZIpERbdc0H7NtWDXtPg-g/viewform',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String utl) {
              setState(() {
                _pageIsLoading = false;
              });
            },
          ),
          if (_pageIsLoading)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColors.scaffoldBackgroundColor,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
