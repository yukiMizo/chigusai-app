import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//notification
import 'screens/notification/notification_setup.dart';

//themes/
import 'themes/app_theme.dart';

import 'bottom_navigation.dart';
//screens/
import 'screens/home_screen.dart';
import 'screens/bunkasai/bunkasai_screen.dart';
import 'screens/zenkou/zenkoukikaku_screen.dart';
//notification/
import 'screens/notification/notification_detail_screen.dart';
import 'screens/notification/notification_screen.dart';
import 'screens/notification/send_notification_screen.dart';
//drawer/
import 'screens/drawer/contact_screen.dart';
import 'screens/drawer/information_screen.dart';
import 'screens/drawer/login_screen.dart';
import 'screens/drawer/pamphlet_screen.dart';
import 'screens/drawer/privacy_policy_screen.dart';
import 'screens/drawer/terms_of_service_screen.dart';
//home/
import 'screens/home/comment_box_screen.dart';
import 'screens/home/map_screen.dart';
import 'screens/home/pr_video_screen.dart';
import 'screens/home/schedule/schedule_screen.dart';
import 'screens/home/theme_song/theme_song_screen.dart';
//bunkasai/
import 'screens/bunkasai/tenji/tenji_detail_screen.dart';
import 'screens/bunkasai/engeki/engeki_detail_screen.dart';
import 'screens/bunkasai/yushi/yushi_detail_screen.dart';
import 'screens/bunkasai/bukatsu/bukatsu_detail_screen.dart';
//taiikusai/
import 'screens/taiikusai/taiikusai_detail_screen.dart';
import 'screens/taiikusai/result_screen.dart';
import 'screens/taiikusai/update_result_screen.dart';
import 'screens/taiikusai/taiikusai_screen.dart';
//zenkou/
import 'screens/zenkou/bihin_screen.dart';
import 'screens/zenkou/sanbon_screen.dart';
import 'screens/zenkou/encore_screen.dart';
import 'screens/zenkou/ff_screen.dart';
import 'screens/zenkou/utakai_screen.dart';
import 'screens/zenkou/zenkoukikaku_screen.dart';
//shift/
import 'screens/shift/shift_screen.dart';
import 'screens/shift/taiikusai/taiikusai_shift_screen.dart';
import 'screens/shift/bunkasai_shift_screen.dart';

void main() async {
  _init();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationSetup.fcmSetup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chigusai App',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      themeMode: ThemeMode.system,
      home: BottomNavigation(),
      routes: {
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        BunkasaiScreen.routeName: (ctx) => const BunkasaiScreen(),
        ZenkoukikakuScreen.routeName: (ctx) => const ZenkoukikakuScreen(),
        TaiikusaiScreen.routeName: (ctx) => const TaiikusaiScreen(),
        //notification
        NotificationScreen.routeName: (ctx) => const NotificationScreen(),
        NotificationDetailScreen.routeName: (ctx) => const NotificationDetailScreen(),
        SendNotificationScreen.routeName: (ctx) => const SendNotificationScreen(),
        //drawer
        ContactScreen.routeName: (ctx) => const ContactScreen(),
        InformationScreen.routeName: (ctx) => const InformationScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        PamphletScreen.routeName: (ctx) => const PamphletScreen(),
        PrivacyPolicyScreen.routeName: (ctx) => const PrivacyPolicyScreen(),
        TermsOfServiceScreen.routeName: (ctx) => const TermsOfServiceScreen(),
        //home
        CommentBoxScreen.routeName: (ctx) => const CommentBoxScreen(),
        MapScreen.routeName: (ctx) => const MapScreen(),
        PRVideoScreen.routeName: (ctx) => const PRVideoScreen(),
        ScheduleScreen.routeName: (ctx) => const ScheduleScreen(),
        ThemeSongScreen.routeName: (ctx) => const ThemeSongScreen(),
        //bunkasai
        TenjiDetailScreen.routeName: (ctx) => const TenjiDetailScreen(),
        EngekiDetailScreen.routeName: (ctx) => const EngekiDetailScreen(),
        YushiDetailScreen.routeName: (ctx) => const YushiDetailScreen(),
        BukatsuDetailScreen.routeName: (ctx) => const BukatsuDetailScreen(),
        //taiikusai/
        TaiikusaiDetailScreen.routeName: (ctx) => const TaiikusaiDetailScreen(),
        UpdateResultScreen.routeName: (ctx) => const UpdateResultScreen(),
        ResultScreen.routeName: (ctx) => const ResultScreen(),
        //zenkou/
        BihinScreen.routeName: (ctx) => const BihinScreen(),
        SabbonScreen.routeName: (ctx) => const SabbonScreen(),
        EncoreScreen.routeName: (ctx) => const EncoreScreen(),
        UtakaiScreen.routeName: (ctx) => const UtakaiScreen(),
        FFScreen.routeName: (ctx) => const FFScreen(),
        //shift/
        ShiftScreen.routeName: (ctx) => const ShiftScreen(),
        TaiikusaiShiftScreen.routeName: (ctx) => const TaiikusaiShiftScreen(),
        BunkasaiShiftScreen.routeName: (ctx) => const BunkasaiShiftScreen(),
      },
    );
  }
}
