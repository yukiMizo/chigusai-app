import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  static const routeName = "/privacy-policy-screen";
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  File? file;

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);

    return file;
  }

  Future<File?> _load(String url) async {
    final data = await rootBundle.load(url);
    final bytes = data.buffer.asUint8List();

    return await _storeFile(url, bytes);
  }

  @override
  void initState() {
    _load('assets/documents/privacy_policy.pdf').then((value) {
      setState(() {
        file = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("プライバシーポリシー")),
      body: file == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PDFView(
                filePath: file!.path,
              ),
            ),
    );
  }
}
