import 'package:flutter/material.dart';

import 'privacy_policy_screen.dart';
import 'terms_of_service_screen.dart';

class InformationScreen extends StatelessWidget {
  static const routeName = "/information-screen";
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("情報")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "アプリについて",
              textAlign: TextAlign.start,
            ),
          ),
          const Divider(),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: TextButton(
              style: TextButton.styleFrom(alignment: Alignment.centerLeft),
              onPressed: () => Navigator.of(context).pushNamed(TermsOfServiceScreen.routeName),
              child: const Text(
                "利用規約",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: TextButton(
              style: TextButton.styleFrom(alignment: Alignment.centerLeft),
              onPressed: () => Navigator.of(context).pushNamed(PrivacyPolicyScreen.routeName),
              child: const Text(
                "プライバシーポリシー",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
