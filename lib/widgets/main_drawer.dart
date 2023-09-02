import 'package:chigusai_app/providers/login_data_provider.dart';
import 'package:flutter/material.dart';

import 'package:chigusai_app/themes/app_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bottom_navigation.dart';

import '../screens/drawer/contact_screen.dart';
import '../screens/drawer/information_screen.dart';
import '../screens/drawer/login_screen.dart';
//import '../screens/drawer/pamphlet_screen.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: AppColors.themeColor),
          child: Text(
            "第61回千種祭",
            style: TextStyle(color: AppColors.lightText1, fontSize: 25),
          ),
        ),
        ListTile(
            title: const Text("ホーム", style: TextStyle(fontSize: 20)),
            onTap: () {
              ref.read(bottomNavigationProvider.notifier).set(0);
              Navigator.popUntil(
                context,
                ModalRoute.withName(Navigator.defaultRouteName),
              );
            }),
        /*
        ListTile(
          title: const Text("パンフレット", style: TextStyle(fontSize: 20)),
          onTap: () => Navigator.of(context).pushNamed(PamphletScreen.routeName),
        ),*/
        ListTile(
          title: const Text("情報", style: TextStyle(fontSize: 20)),
          onTap: () => Navigator.of(context).pushNamed(InformationScreen.routeName),
        ),
        ListTile(
          title: const Text("お問い合わせ", style: TextStyle(fontSize: 20)),
          onTap: () => Navigator.of(context).pushNamed(ContactScreen.routeName),
        ),
        const Divider(color: Colors.grey),
        if (ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.notLoggedIn)
          ListTile(
            title: const Text("ログイン", style: TextStyle(fontSize: 20)),
            onTap: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
          )
        else
          ListTile(
            title: const Text("ログアウト", style: TextStyle(fontSize: 20)),
            onTap: () async {
              //ログアウト
              await LoginDataManager.logout(ref);
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("ログアウトしました")),
              );

              ref.read(bottomNavigationProvider.notifier).set(0);
              // ignore: use_build_context_synchronously
              Navigator.popUntil(
                context,
                ModalRoute.withName(Navigator.defaultRouteName),
              );
            },
          ),
        /*
        ListTile(
          title: const Text("設定", style: TextStyle(fontSize: 20)),
          onTap: () => Navigator.of(context).pushNamed(InformationScreen.routeName),
        ),*/
      ]),
    );
  }
}
