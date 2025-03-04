import 'package:flutter/material.dart';

/// Base theme class that defines the structure for all MotoMeet themes
abstract class AppTheme {
  // Theme identification
  String get name;
  String get description;
  
  // Color schemes
  ThemeData get lightTheme;
  ThemeData get darkTheme;
  
  // Core colors
  Color get primaryColor;
  Color get secondaryColor;
  Color get accentColor;
  Color get backgroundColor;
  Color get surfaceColor;
  Color get errorColor;
  Color get successColor;
  Color get warningColor;
  Color get infoColor;

  // Text styles
  TextStyle get headlineLarge;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;
  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get titleSmall;
  TextStyle get bodyLarge;
  TextStyle get bodyMedium;
  TextStyle get bodySmall;
  TextStyle get labelLarge;
  TextStyle get labelMedium;
  TextStyle get labelSmall;
  
  // Specific widget styling
  BoxDecoration get cardDecoration;
  BoxDecoration get dialogDecoration;
  BoxDecoration get bottomSheetDecoration;
  InputDecoration inputDecoration({String? hintText, String? labelText, Widget? prefixIcon, Widget? suffixIcon});
  ButtonStyle get primaryButtonStyle;
  ButtonStyle get secondaryButtonStyle;
  ButtonStyle get textButtonStyle;
  
  // Navigation styling
  BottomNavigationBarThemeData get bottomNavBarTheme;
  AppBarTheme get appBarTheme;
  TabBarTheme get tabBarTheme;
  
  // Form elements
  CheckboxThemeData get checkboxTheme;
  RadioThemeData get radioTheme;
  SwitchThemeData get switchTheme;
  SliderThemeData get sliderTheme;
  
  // Additional elements
  FloatingActionButtonThemeData get fabTheme;
  CardTheme get cardTheme;
  DialogTheme get dialogTheme;
  SnackBarThemeData get snackBarTheme;
  
  // Helper methods
  Color getOnColor(Color backgroundColor) {
    return ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark 
      ? Colors.white 
      : Colors.black;
  }
}
