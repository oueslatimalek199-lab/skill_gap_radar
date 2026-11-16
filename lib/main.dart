import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/welcome/welcome_page.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const SkillGapRadarApp());
}

class SkillGapRadarApp extends StatelessWidget {
  const SkillGapRadarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (_, mode, __) {
        SystemChrome.setSystemUIOverlayStyle(
          mode == ThemeMode.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
        );

        return MaterialApp(
          title: 'Skill Gap Radar',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          home: const WelcomePage(),
        );
      },
    );
  }
}