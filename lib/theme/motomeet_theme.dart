import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

class MotoMeetTheme extends AppTheme {
  // TODO: The user should download and add the 'Inter' font to the project.
  // Using Lato as a placeholder.
  final String _fontFamily = GoogleFonts.lato().fontFamily!;

  @override
  String get name => 'MotoMeet Theme';
  @override
  String get description => 'The official theme for the MotoMeet application.';

  // --- Color Palette ---
  static const Color _primaryColor = Color(0xFF2563EB);
  static const Color _secondaryColor = Color(0xFF6B7280);
  static const Color _accentColor = Color(0xFF2563EB);
  static const Color _errorColor = Color(0xFFEF4444);
  static const Color _successColor = Color(0xFF15803D);
  static const Color _warningColor = Color(0xFFF59E0B);
  static const Color _infoColor = Color(0xFF3B82F6);

  // Light Theme Colors
  static const Color _lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color _lightSurfaceColor = Color(0xFFF3F4F6);
  static const Color _lightOnPrimaryColor = Color(0xFFFFFFFF);
  static const Color _lightOnSecondaryColor = Color(0xFFFFFFFF);
  static const Color _lightOnBackgroundColor = Color(0xFF1F2937);
  static const Color _lightOnSurfaceColor = Color(0xFF1F2937);
  static const Color _lightOnErrorColor = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color _darkBackgroundColor = Color(0xFF111827);
  static const Color _darkSurfaceColor = Color(0xFF1F2937);
  static const Color _darkOnPrimaryColor = Color(0xFFFFFFFF);
  static const Color _darkOnSecondaryColor = Color(0xFFFFFFFF);
  static const Color _darkOnBackgroundColor = Color(0xFFF9FAFB);
  static const Color _darkOnSurfaceColor = Color(0xFFF9FAFB);
  static const Color _darkOnErrorColor = Color(0xFFFFFFFF);

  @override
  Color get primaryColor => _primaryColor;
  @override
  Color get secondaryColor => _secondaryColor;
  @override
  Color get accentColor => _accentColor;
  @override
  Color get backgroundColor => _lightBackgroundColor; // Default to light
  @override
  Color get surfaceColor => _lightSurfaceColor; // Default to light
  @override
  Color get errorColor => _errorColor;
  @override
  Color get successColor => _successColor;
  @override
  Color get warningColor => _warningColor;
  @override
  Color get infoColor => _infoColor;

  ThemeData _buildTheme(ColorScheme colorScheme, Brightness brightness) {
    return ThemeData(
      colorScheme: colorScheme,
      brightness: brightness,
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: colorScheme.background,
      fontFamily: _fontFamily,
      textTheme: _textTheme(colorScheme),
      appBarTheme: appBarTheme,
      cardTheme: cardTheme,
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      elevatedButtonTheme: _elevatedButtonTheme(),
      outlinedButtonTheme: _outlinedButtonTheme(),
      textButtonTheme: _textButtonTheme(),
      bottomNavigationBarTheme: bottomNavBarTheme,
      tabBarTheme: tabBarTheme,
      floatingActionButtonTheme: fabTheme,
      checkboxTheme: checkboxTheme,
      radioTheme: radioTheme,
      switchTheme: switchTheme,
      sliderTheme: sliderTheme,
      dialogTheme: dialogTheme,
      snackBarTheme: snackBarTheme,
    );
  }

  TextTheme _textTheme(ColorScheme colorScheme) {
    return GoogleFonts.latoTextTheme(TextTheme(
      headlineLarge: headlineLarge.copyWith(color: colorScheme.onBackground),
      headlineMedium: headlineMedium.copyWith(color: colorScheme.onBackground),
      headlineSmall: headlineSmall.copyWith(color: colorScheme.onBackground),
      titleLarge: titleLarge.copyWith(color: colorScheme.onBackground),
      titleMedium: titleMedium.copyWith(color: colorScheme.onBackground),
      titleSmall: titleSmall.copyWith(color: colorScheme.onBackground),
      bodyLarge: bodyLarge.copyWith(color: colorScheme.onBackground),
      bodyMedium: bodyMedium.copyWith(color: colorScheme.onBackground),
      bodySmall: bodySmall.copyWith(color: colorScheme.onSecondary),
      labelLarge: labelLarge.copyWith(color: colorScheme.onBackground),
      labelMedium: labelMedium.copyWith(color: colorScheme.onSurface),
      labelSmall: labelSmall.copyWith(color: colorScheme.onSurface),
    ));
  }
  
  InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: colorScheme.surface.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: colorScheme.error, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: colorScheme.error, width: 2.0),
      ),
      hintStyle: bodyMedium.copyWith(color: colorScheme.onSurface.withOpacity(0.6)),
      labelStyle: bodyMedium.copyWith(color: colorScheme.onSurface),
      prefixIconColor: colorScheme.onSurface.withOpacity(0.8),
      suffixIconColor: colorScheme.onSurface.withOpacity(0.8),
    );
  }

  ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: primaryButtonStyle,
    );
  }

  OutlinedButtonThemeData _outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: secondaryButtonStyle,
    );
  }

  TextButtonThemeData _textButtonTheme() {
    return TextButtonThemeData(
      style: textButtonStyle,
    );
  }

  @override
  ThemeData get lightTheme => _buildTheme(_lightColorScheme, Brightness.light);

  @override
  ThemeData get darkTheme => _buildTheme(_darkColorScheme, Brightness.dark);

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _primaryColor,
    onPrimary: _lightOnPrimaryColor,
    secondary: _secondaryColor,
    onSecondary: _lightOnSecondaryColor,
    error: _errorColor,
    onError: _lightOnErrorColor,
    background: _lightBackgroundColor,
    onBackground: _lightOnBackgroundColor,
    surface: _lightSurfaceColor,
    onSurface: _lightOnSurfaceColor,
  );

  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _primaryColor,
    onPrimary: _darkOnPrimaryColor,
    secondary: _secondaryColor,
    onSecondary: _darkOnSecondaryColor,
    error: _errorColor,
    onError: _darkOnErrorColor,
    background: _darkBackgroundColor,
    onBackground: _darkOnBackgroundColor,
    surface: _darkSurfaceColor,
    onSurface: _darkOnSurfaceColor,
  );

  // --- Text Styles ---
  @override
  TextStyle get headlineLarge => TextStyle(fontFamily: _fontFamily, fontSize: 28, fontWeight: FontWeight.bold);
  @override
  TextStyle get headlineMedium => TextStyle(fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.bold);
  @override
  TextStyle get headlineSmall => TextStyle(fontFamily: _fontFamily, fontSize: 20, fontWeight: FontWeight.w700);
  @override
  TextStyle get titleLarge => TextStyle(fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w600);
  @override
  TextStyle get titleMedium => TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.w600);
  @override
  TextStyle get titleSmall => TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500);
  @override
  TextStyle get bodyLarge => TextStyle(fontFamily: _fontFamily, fontSize: 16, fontWeight: FontWeight.normal);
  @override
  TextStyle get bodyMedium => TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.normal);
  @override
  TextStyle get bodySmall => TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.normal);
  @override
  TextStyle get labelLarge => TextStyle(fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.5);
  @override
  TextStyle get labelMedium => TextStyle(fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w500);
  @override
  TextStyle get labelSmall => TextStyle(fontFamily: _fontFamily, fontSize: 10, fontWeight: FontWeight.w500);
  
  // --- Component Styles ---
  @override
  BoxDecoration get cardDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      )
    ],
  );

  @override
  InputDecoration inputDecoration({String? hintText, String? labelText, Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  @override
  ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: _primaryColor,
    foregroundColor: _lightOnPrimaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: titleMedium,
  );
  
  @override
  ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: _primaryColor,
    side: const BorderSide(color: _primaryColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    textStyle: titleMedium,
  );
  
  @override
  ButtonStyle get textButtonStyle => TextButton.styleFrom(
    foregroundColor: _primaryColor,
    textStyle: titleMedium,
  );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: _lightBackgroundColor,
    elevation: 0,
    iconTheme: const IconThemeData(color: _lightOnBackgroundColor),
    titleTextStyle: titleLarge.copyWith(color: _lightOnBackgroundColor),
  );

  @override
  BottomNavigationBarThemeData get bottomNavBarTheme => BottomNavigationBarThemeData(
    backgroundColor: _lightBackgroundColor,
    selectedItemColor: _primaryColor,
    unselectedItemColor: _secondaryColor,
    selectedLabelStyle: labelMedium,
    unselectedLabelStyle: labelMedium,
    type: BottomNavigationBarType.fixed,
  );

  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
    labelColor: _primaryColor,
    unselectedLabelColor: _secondaryColor,
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(color: _primaryColor, width: 2.0),
    ),
    labelStyle: titleSmall,
    unselectedLabelStyle: titleSmall,
  );

  @override
  CardTheme get cardTheme => CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    clipBehavior: Clip.antiAlias,
  );

  @override
  DialogTheme get dialogTheme => DialogTheme(
    backgroundColor: _lightBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  );
  
  @override
  FloatingActionButtonThemeData get fabTheme => const FloatingActionButtonThemeData(
    backgroundColor: _primaryColor,
    foregroundColor: _lightOnPrimaryColor,
  );
  
  @override
  CheckboxThemeData get checkboxTheme => CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return _secondaryColor;
    }),
    checkColor: MaterialStateProperty.all(_lightOnPrimaryColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  );
  
  @override
  RadioThemeData get radioTheme => RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return _secondaryColor;
    }),
  );

  @override
  SwitchThemeData get switchTheme => SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _primaryColor;
      }
      return _lightSurfaceColor;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return _primaryColor.withOpacity(0.5);
      }
      return _secondaryColor.withOpacity(0.3);
    }),
  );

  @override
  SliderThemeData get sliderTheme => SliderThemeData(
    activeTrackColor: _primaryColor,
    inactiveTrackColor: _primaryColor.withOpacity(0.3),
    thumbColor: _primaryColor,
  );

  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
    backgroundColor: _darkSurfaceColor,
    contentTextStyle: bodyMedium.copyWith(color: _darkOnSurfaceColor),
    actionTextColor: _primaryColor,
  );

  @override
  BoxDecoration get bottomSheetDecoration => const BoxDecoration(
    color: _lightBackgroundColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    ),
  );

  @override
  BoxDecoration get dialogDecoration => BoxDecoration(
    color: _lightBackgroundColor,
    borderRadius: BorderRadius.circular(16.0),
  );
} 