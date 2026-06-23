import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spendly_app/core/theme/app_theme.dart';

import '../utils/values/app_strings.dart';

enum ThemeModeOption { system, light, dark }

class ThemeController extends GetxController {
  static const _key = 'theme_mode';
  final _storage = GetStorage();
  final Rx<ThemeModeOption> mode = ThemeModeOption.system.obs;

  ThemeMode get themeMode {
    switch (mode.value) {
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
      case ThemeModeOption.system:
        return ThemeMode.system;
    }
  }

  ThemeData get lightTheme => AppTheme.lightTheme;
  ThemeData get darkTheme => AppTheme.darkTheme;

  @override
  void onInit() {
    super.onInit();
    final saved = _storage.read<String>(_key);
    if (saved != null) {
      mode.value = ThemeModeOption.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => ThemeModeOption.system,
      );
    }
  }

  void setMode(ThemeModeOption option) {
    mode.value = option;
    _storage.write(_key, option.name);
    Get.changeThemeMode(themeMode);
  }

  void toggleDarkLight() {
    final isDark = Get.isDarkMode;
    setMode(isDark ? ThemeModeOption.light : ThemeModeOption.dark);
  }

  String labelFor(ThemeModeOption option) {
    switch (option) {
      case ThemeModeOption.light:
        return AppStrings.themeLight;
      case ThemeModeOption.dark:
        return AppStrings.themeDark;
      case ThemeModeOption.system:
        return AppStrings.themeSystem;
    }
  }
}
