import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  static const routeName = "/terms-of-service-screen";

  const TermsOfServiceScreen({super.key});

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
      appBar: AppBar(title: const Text("利用規約")),
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
                    "利用規約",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "1. アプリの使用",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText(
                      "a.", "ユーザーは、「HR対抗アプリ」（以下、本アプリ)を個人的な目的で利用できます。"),
                  _indentedText("b.", "本アプリやそれに関わるデータを不正に改変する行為を禁止します。"),
                  _indentedText("c.", "本アプリを不正に複製、配布する行為を禁止します。"),
                  _indentedText("d.", "その他、著作者が不適切だと判断した行為を禁止します。"),
                  _indentedText("e.", "ユーザーは、自身が提供する情報が正確であることを保証するものとします。"),
                  _indentedText("f.",
                      "ユーザーが、本アプリ内で提供した個人情報については「プライバシーポリシー」に基づいて扱われるものとします。"),
                  const SizedBox(height: 5),
                  const Text(
                    "2. 知的財産権",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.",
                      "本アプリの著作権、商標権、特許権、その他の知的財産権は、著作者である溝口優生、石原裕己に帰属します。"),
                  _indentedText("b.",
                      "ユーザーは、本アプリ内で表示される情報やコンテンツを個人的な目的で利用することができますが、これらの情報やコンテンツを商業的な目的で利用することはできません。"),
                  const SizedBox(height: 5),
                  const Text(
                    "3. 免責事項",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText(
                      "a.", "本アプリには、情報の遅れや間違いが生じる可能性があり、正確性や信頼性について保証しません。"),
                  _indentedText("b.",
                      "本アプリは試験段階であり、サービスを停止する場合があります。この際に生じた損害について、著作者は責任を負いません。"),
                  _indentedText("c.", "本アプリの利用によって生じた損害について、著作者は責任を負いません。"),
                  const SizedBox(height: 5),
                  const Text(
                    "4. 利用規約の変更",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  _indentedText("a.", "利用規約は、事前の通知なしに変更されることがあります。"),
                  _indentedText("b.", "利用規約が変更された場合、本アプリでユーザーへ通知します。"),
                  _indentedText("c.", "利用規約が変更された場合、変更後の利用規約が適用されるものとします。"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
