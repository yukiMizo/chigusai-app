import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeName = "/privacy-policy-screen";

  const PrivacyPolicyScreen({super.key});

  Widget _indentedText(
    String leading,
    String text,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Text(leading),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("プライバシーポリシー")),
      body: SizedBox(
        width: double.infinity,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "プライバシーポリシー",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "1. 収集する情報",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.", "本アプリでは、基本的にユーザーの個人情報を収集しません。しかし、不具合発生状況などの詳細な情報を収集する際、ユーザーの情報や使用するデバイスの情報、アプリの使用方法などを求める場合があります。"),
                  _indentedText("b.", "収集した個人情報はアプリの機能改善以外の目的では使用しません。"),
                  const SizedBox(height: 5),
                  const Text(
                    "2. 取り扱いに関する情報",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.", "収集した情報は機能改善の目的でのみ次の開発者へ引き継ぐ可能性があります。"),
                  const SizedBox(height: 5),
                  const Text(
                    "3. セキュリティに関する情報",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.", "収集した情報については、第三者への意図せぬ流出などがないように責任をもって保管します。"),
                  const SizedBox(height: 5),
                  const Text(
                    "4. ユーザーの選択肢に関する情報",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.", "ユーザーの情報など機密性が高い情報についてはユーザーが提供するか選択できるようにします。"),
                  const SizedBox(height: 5),
                  const Text(
                    "5. 制定日",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.", "制定　2023年3月2日"),
                  _indentedText("b.", "変更(1) 2023年3月29日"),
                  const SizedBox(height: 5),
                  const Text(
                    "6. 問い合わせ先",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.", "アプリ内のGoogleFormから問い合わせてください。"),
                  const SizedBox(height: 5),
                  const Text(
                    "7. 変更に関する情報",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.", "プライバシーポリシーは、事前の通知なしに変更されることがあります。"),
                  _indentedText("b.", "プライバシーポリシーが変更された場合、変更後のプライバシーポリシーが適用されるものとします。"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
