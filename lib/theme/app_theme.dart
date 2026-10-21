// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ---------------------------------------------------------------
/// 1. COLOURS
/// ---------------------------------------------------------------
class AppColors {
  AppColors._();

  // Brand
  static const radar = Color(0xFF2DE2C4); // primary: phosphor teal
  static const radarDeep = Color(0xFF14B8A0);
  static const violet = Color(0xFF7C6CFF); // secondary
  static const amber = Color(0xFFFFB547); // gaps / missing skills

  // Semantic
  static const success = Color(0xFF3DDC97); // matched
  static const danger = Color(0xFFFF5C7A); // critical gap / errors
  static const info = Color(0xFF5CB8FF);

  // Dark surfaces
  static const ink = Color(0xFF0A0F1E); // scaffold
  static const surface = Color(0xFF111827); // cards
  static const surfaceHigh = Color(0xFF1A2338); // inputs, chips, sheets
  static const outline = Color(0xFF263250); // borders, dividers
  static const textPrimary = Color(0xFFEAF0FF);
  static const textMuted = Color(0xFF8E9ABB);

  // Light surfaces
  static const paper = Color(0xFFF4F7FB);
  static const card = Color(0xFFFFFFFF);
  static const paperOutline = Color(0xFFDCE3EF);
  static const lightText = Color(0xFF0E1530);
  static const lightMuted = Color(0xFF5B678A);

  // Gradients
  static const brandGradient = LinearGradient(
    colors: [radar, violet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gapGradient = LinearGradient(
    colors: [amber, danger],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Colour for a match score (0–100).
  static Color scoreColor(double score) {
    if (score >= 75) return success;
    if (score >= 50) return radar;
    if (score >= 30) return amber;
    return danger;
  }
}

/// Colours dedicated to the radar chart (use with fl_chart / custom painter).
class RadarChartColors {
  RadarChartColors._();
  static const userFill = Color(0x442DE2C4); // your skills
  static const userStroke = AppColors.radar;
  static const offerFill = Color(0x33FFB547); // what the offer requires
  static const offerStroke = AppColors.amber;
  static const grid = Color(0xFF263250);
  static const label = AppColors.textMuted;
}

/// ---------------------------------------------------------------
/// 2. SPACING & SHAPE
/// ---------------------------------------------------------------
class AppSpacing {
  AppSpacing._();
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

class AppRadius {
  AppRadius._();
  static const sm = 10.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const pill = 100.0;
}

/// ---------------------------------------------------------------
/// 3. TYPOGRAPHY
/// Space Grotesk = headings & numbers (technical, distinctive)
/// Inter         = body & UI text (clean, readable)
/// ---------------------------------------------------------------
TextTheme _textTheme(Color primary, Color muted) {
  final heading = GoogleFonts.spaceGroteskTextTheme();
  final body = GoogleFonts.interTextTheme();

  return TextTheme(
    displayLarge: heading.displayLarge?.copyWith(
      fontSize: 56,
      fontWeight: FontWeight.w700,
      color: primary,
      letterSpacing: -1.5,
    ),
    displayMedium: heading.displayMedium?.copyWith(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      color: primary,
      letterSpacing: -1,
    ),
    headlineLarge: heading.headlineLarge?.copyWith(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: primary,
      letterSpacing: -0.5,
    ),
    headlineMedium: heading.headlineMedium?.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: primary,
    ),
    titleLarge: heading.titleLarge?.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: primary,
    ),
    titleMedium: body.titleMedium?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: primary,
    ),
    bodyLarge: body.bodyLarge?.copyWith(
      fontSize: 16,
      height: 1.5,
      color: primary,
    ),
    bodyMedium: body.bodyMedium?.copyWith(
      fontSize: 14,
      height: 1.5,
      color: muted,
    ),
    bodySmall: body.bodySmall?.copyWith(
      fontSize: 12,
      height: 1.4,
      color: muted,
    ),
    labelLarge: body.labelLarge?.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelSmall: body.labelSmall?.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
      color: muted,
    ),
  );
}

/// Big score number (e.g. "78%")
class AppText {
  AppText._();
  static TextStyle score(Color color) => GoogleFonts.spaceGrotesk(
    fontSize: 64,
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: -2,
  );
}

/// ---------------------------------------------------------------
/// 4. THEMES
/// ---------------------------------------------------------------
class AppTheme {
  AppTheme._();

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    scaffold: AppColors.ink,
    surface: AppColors.surface,
    surfaceHigh: AppColors.surfaceHigh,
    outline: AppColors.outline,
    text: AppColors.textPrimary,
    muted: AppColors.textMuted,
    onPrimary: AppColors.ink,
  );

  static ThemeData get light => _build(
    brightness: Brightness.light,
    scaffold: AppColors.paper,
    surface: AppColors.card,
    surfaceHigh: const Color(0xFFEAF0F8),
    outline: AppColors.paperOutline,
    text: AppColors.lightText,
    muted: AppColors.lightMuted,
    onPrimary: AppColors.ink,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color scaffold,
    required Color surface,
    required Color surfaceHigh,
    required Color outline,
    required Color text,
    required Color muted,
    required Color onPrimary,
  }) {
    final isDark = brightness == Brightness.dark;
    final primary = isDark ? AppColors.radar : AppColors.radarDeep;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      secondary: AppColors.violet,
      onSecondary: Colors.white,
      tertiary: AppColors.amber,
      onTertiary: AppColors.ink,
      error: AppColors.danger,
      onError: Colors.white,
      surface: surface,
      onSurface: text,
      surfaceContainerHighest: surfaceHigh,
      outline: outline,
    );

    final textTheme = _textTheme(text, muted);

    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: c, width: w),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      dividerTheme: DividerThemeData(color: outline, thickness: 1, space: 1),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: text,
        titleTextStyle: textTheme.titleLarge,
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: outline),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          elevation: 0,
          minimumSize: const Size.fromHeight(54),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size.fromHeight(54),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          minimumSize: const Size.fromHeight(54),
          side: BorderSide(color: outline, width: 1.2),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: textTheme.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceHigh,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        hintStyle: textTheme.bodyMedium,
        labelStyle: textTheme.bodyMedium,
        border: border(outline),
        enabledBorder: border(outline),
        focusedBorder: border(primary, 1.6),
        errorBorder: border(AppColors.danger),
        focusedErrorBorder: border(AppColors.danger, 1.6),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surfaceHigh,
        selectedColor: primary.withOpacity(0.18),
        side: BorderSide(color: outline),
        labelStyle: textTheme.bodySmall?.copyWith(
          color: text,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primary.withOpacity(0.16),
        height: 70,
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelSmall?.copyWith(letterSpacing: 0.3),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected) ? primary : muted,
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: outline,
        thumbColor: primary,
        overlayColor: primary.withOpacity(0.15),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: outline,
        circularTrackColor: outline,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: surfaceHigh,
        contentTextStyle: textTheme.bodyLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? onPrimary : muted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? primary : outline,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
    );
  }
}
