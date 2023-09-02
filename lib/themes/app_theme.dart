import 'package:flutter/material.dart';
import 'app_color.dart';

ThemeData appTheme() => ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.themeColor,
      foregroundColor: AppColors.lightText1,
    ),
    useMaterial3: true,
    fontFamily: "NotoSansJP",
    snackBarTheme: const SnackBarThemeData(showCloseIcon: true),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.themeColor).copyWith(secondary: AppColors.accentColor),
    dialogTheme: const DialogTheme(backgroundColor: Colors.white));
