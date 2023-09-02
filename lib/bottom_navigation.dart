import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './providers/login_data_provider.dart';

import 'screens/home_screen.dart';
import 'screens/taiikusai/taiikusai_screen.dart';
import 'screens/bunkasai/bunkasai_screen.dart';
import 'screens/zenkou/zenkoukikaku_screen.dart';
import 'screens/home/map_screen.dart';
import 'screens/shift/shift_screen.dart';

class BottomNavigatorNotifier extends StateNotifier<ViewType> {
  BottomNavigatorNotifier() : super(ViewType.home);

  final List<ViewType> _viewTypes = [
    ViewType.home,
    ViewType.taiikusai,
    ViewType.bunkasai,
    ViewType.zenkoukikaku,
    ViewType.map,
  ];

  void set(int index) {
    state = _viewTypes[index];
  }

  void reset() => state = ViewType.home;
}

final bottomNavigationProvider = StateNotifierProvider<BottomNavigatorNotifier, ViewType>((ref) => BottomNavigatorNotifier());

enum ViewType { home, taiikusai, bunkasai, zenkoukikaku, map }

class BottomNavigation extends ConsumerWidget {
  BottomNavigation({Key? key}) : super(key: key);

  final widgetsNotLoggedIn = [
    const HomeScreen(),
    const TaiikusaiScreen(),
    const BunkasaiScreen(),
    const ZenkoukikakuScreen(),
    const MapScreen(),
  ];
  final widgetsLoggedIn = [
    const HomeScreen(),
    const TaiikusaiScreen(),
    const BunkasaiScreen(),
    const ZenkoukikakuScreen(),
    const ShiftScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(bottomNavigationProvider);
    final List<Widget> widgets = ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.notLoggedIn ? widgetsNotLoggedIn : widgetsLoggedIn;
    return Scaffold(
      body: widgets[view.index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          const BottomNavigationBarItem(icon: Icon(Icons.change_history), label: '体育祭'),
          const BottomNavigationBarItem(icon: Icon(Icons.fiber_manual_record_outlined), label: '文化祭'),
          const BottomNavigationBarItem(icon: Icon(Icons.check_box_outline_blank), label: '全校企画'),
          ref.watch(currentLoginStatusProvider) == CurrentLoginStatus.notLoggedIn
              ? const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'マップ')
              : const BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'シフト'),
        ],
        currentIndex: view.index,
        onTap: (int index) => ref.read(bottomNavigationProvider.notifier).set(index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
