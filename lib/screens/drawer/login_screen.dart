import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../bottom_navigation.dart';

import '../../providers/login_data_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/sign-in-screen";

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;
  LoginType? _selectedLoginType;

  Widget _buildRadioButtonSection() {
    return Column(
      children: [
        const Text(
          "ログイン",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        RadioListTile(
          title: const Text('一般生徒'),
          value: LoginType.student,
          groupValue: _selectedLoginType,
          onChanged: (value) {
            setState(() {
              _selectedLoginType = value;
            });
          },
        ),
        RadioListTile(
          title: const Text('学祭関係者'),
          value: LoginType.staff,
          groupValue: _selectedLoginType,
          onChanged: (value) {
            setState(() {
              _selectedLoginType = value;
            });
          },
        ),
        RadioListTile(
          title: const Text('管理者'),
          value: LoginType.admin,
          groupValue: _selectedLoginType,
          onChanged: (value) {
            setState(() {
              _selectedLoginType = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      children: [
        const Text(
          "パスワード",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        TextField(
          onChanged: (_) => setState(() {}),
          controller: _passwordController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).disabledColor),
              borderRadius: BorderRadius.circular(5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: (_passwordController.text != "" && _selectedLoginType != null)
            ? () async {
                setState(() {
                  _isLoading = true;
                });
                //firebaseからパスワードを取得
                var data = await FirebaseFirestore.instance.collection("password").doc("passwordDoc").get();
                //パスワードが合っているか確認
                bool canLogin = false;
                switch (_selectedLoginType!) {
                  case LoginType.student:
                    if (_passwordController.text == data["student"]) {
                      canLogin = true;
                    }
                    break;
                  case LoginType.staff:
                    if (_passwordController.text == data["staff"]) {
                      canLogin = true;
                    }
                    break;
                  case LoginType.admin:
                    if (_passwordController.text == data["admin"]) {
                      canLogin = true;
                    }
                    break;
                }
                //ログイン
                if (canLogin) {
                  await LoginDataManager.login(ref, _selectedLoginType!);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("ログインに成功しました"),
                    ),
                  );
                  ref.read(bottomNavigationProvider.notifier).set(0);
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(Navigator.defaultRouteName),
                  );
                } else {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("パスワードが違います"),
                    ),
                  );
                }
                setState(() {
                  _isLoading = false;
                });
              }
            : null,
        child: const Text("ログイン"),
      ),
    );
  }

  /*Widget _buildLogoutbutton() {
    return FilledButton(
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        //ログアウト
        await LoginDataManager.logout(ref);
        if (!mounted) return;
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ログアウトしました")),
        );

        ref.read(bottomNavigationProvider.notifier).set(0);
        Navigator.popUntil(
          context,
          ModalRoute.withName(Navigator.defaultRouteName),
        );
        setState(() {
          _isLoading = false;
        });
      },
      child: const Text("ログアウト"),
    );
  }*/

  Widget _buildLoginScreen() {
    return Column(children: [
      _buildRadioButtonSection(),
      const SizedBox(height: 30),
      _buildPasswordSection(),
      const SizedBox(height: 15),
      _isLoading ? const CircularProgressIndicator() : _buildLoginButton(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ログイン")),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20), child: _buildLoginScreen()),
          ),
        ),
      ),
    );
  }
}
