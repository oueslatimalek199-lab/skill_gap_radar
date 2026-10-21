// lib/core/theme/theme_controller.dart
import 'package:flutter/material.dart';

/// Global theme mode. Later you can persist it (BF14 - Settings).
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(
  ThemeMode.dark,
);

void toggleThemeMode() {
  themeModeNotifier.value = themeModeNotifier.value == ThemeMode.dark
      ? ThemeMode.light
      : ThemeMode.dark;
}
