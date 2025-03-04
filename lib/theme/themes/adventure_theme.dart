import 'package:flutter/material.dart';
import '../app_theme.dart';

class AdventureTheme extends AppTheme {
  // Theme identification
  @override
  String get name => 'Adventure';
  
  @override
  String get description => 'A rugged, outdoor-inspired design with earthy tones and trail elements';
  
  // Base Colors
  final Color _primaryLight = const Color(0xFF3E6C51); // Forest green
  final Color _primaryDark = const Color(0xFF2A4D3A);
  final Color _secondaryLight = const Color(0xFFD59F33); // Amber gold
  final Color _secondaryDark = const Color(0xFFBF8B2C);
  final Color _accentLight = const Color(0xFFE76F51); // Terracotta
  final Color _accentDark = const Color(0xFFD15941);
  
  final Color _backgroundLight = const Color(0xFFF5F2EA); // Light parchment
  final Color _backgroundDark = const Color(0xFF1F2A22); // Deep forest
  final Color _surfaceLight = const Color(0xFFFFFFFF);
  final Color _surfaceDark = const Color(0xFF2D3A30);
  
  final Color _errorLight = const Color(0xFFD32F2F);
  final Color _errorDark = const Color(0xFFEF5350);
  final Color _successLight = const Color(0xFF388E3C);
  final Color _successDark = const Color(0xFF4CAF50);
  final Color _warningLight = const Color(0xFFF9A825);
  final Color _warningDark = const Color(0xFFFFB74D);
  final Color _infoLight = const Color(0xFF1976D2);
  final Color _infoDark = const Color(0xFF64B5F6);

  // Font family
  final String _fontFamily = 'Montserrat';

  @override
  ThemeData get lightTheme {
    // ... existing code ...
  }
  
  @override
  ThemeData get darkTheme {
    // ... existing code ...
  }

  TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    // ... existing code ...
  }

  // Core colors
  @override
  Color get primaryColor => _primaryLight;
  
  @override
  Color get secondaryColor => _secondaryLight;
  
  @override
  Color get accentColor => _accentLight;
  
  @override
  Color get backgroundColor => _backgroundLight;
  
  @override
  Color get surfaceColor => _surfaceLight;
  
  @override
  Color get errorColor => _errorLight;
  
  @override
  Color get successColor => _successLight;
  
  @override
  Color get warningColor => _warningLight;
  
  @override
  Color get infoColor => _infoLight;

  // Text styles
  @override
  TextStyle get headlineLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );
  
  @override
  TextStyle get headlineMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );
  
  @override
  TextStyle get headlineSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
  );
  
  @override
  TextStyle get titleLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );
  
  @override
  TextStyle get titleMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );
  
  @override
  TextStyle get titleSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );
  
  @override
  TextStyle get bodyLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  
  @override
  TextStyle get bodyMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  
  @override
  TextStyle get bodySmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );
  
  @override
  TextStyle get labelLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );
  
  @override
  TextStyle get labelMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.0,
  );
  
  @override
  TextStyle get labelSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
  );

  // Widget decoration
  @override
  BoxDecoration get cardDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 6,
        offset: Offset(0, 2),
      ),
    ],
    image: DecorationImage(
      image: AssetImage('assets/images/paper_texture.png'),
      fit: BoxFit.cover,
      opacity: 0.05,
    ),
  );
  
  @override
  BoxDecoration get dialogDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );
  
  @override
  BoxDecoration get bottomSheetDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        blurRadius: 8,
        offset: Offset(0, -2),
      ),
    ],
  );

  @override
  InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: surfaceColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryColor),
      ),
      labelStyle: bodyMedium.copyWith(color: Colors.black87),
      hintStyle: bodyMedium.copyWith(color: Colors.black38),
      errorStyle: bodySmall.copyWith(color: errorColor),
    );
  }

  @override
  ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    textStyle: labelLarge.copyWith(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
  );
  
  @override
  ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    side: BorderSide(color: primaryColor),
    textStyle: labelLarge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  
  @override
  ButtonStyle get textButtonStyle => TextButton.styleFrom(
    foregroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textStyle: labelLarge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // Navigation styling
  @override
  BottomNavigationBarThemeData get bottomNavBarTheme => BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: surfaceColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.black54,
    selectedLabelStyle: labelSmall,
    unselectedLabelStyle: labelSmall,
    elevation: 8,
  );
  
  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
    titleTextStyle: titleLarge.copyWith(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16),
      ),
    ),
  );
  
  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
    labelColor: primaryColor,
    unselectedLabelColor: Colors.black54,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: labelLarge,
    unselectedLabelStyle: labelLarge.copyWith(fontWeight: FontWeight.w400),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(width: 2.0, color: primaryColor),
    ),
  );
  
  // Form elements
  @override
  CheckboxThemeData get checkboxTheme => CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return Colors.transparent;
    }),
    checkColor: MaterialStateProperty.all(Colors.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
    side: BorderSide(color: primaryColor.withOpacity(0.6), width: 1.5),
  );
  
  @override
  RadioThemeData get radioTheme => RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return Colors.black54;
    }),
  );
  
  @override
  SwitchThemeData get switchTheme => SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return Colors.grey;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor.withOpacity(0.4);
      }
      return Colors.grey.withOpacity(0.4);
    }),
  );
  
  @override
  SliderThemeData get sliderTheme => SliderThemeData(
    activeTrackColor: primaryColor,
    inactiveTrackColor: primaryColor.withOpacity(0.3),
    thumbColor: primaryColor,
    overlayColor: primaryColor.withOpacity(0.2),
    valueIndicatorColor: primaryColor,
    valueIndicatorTextStyle: labelMedium.copyWith(color: Colors.white),
    showValueIndicator: ShowValueIndicator.always,
  );
  
  // Additional elements
  @override
  FloatingActionButtonThemeData get fabTheme => FloatingActionButtonThemeData(
    backgroundColor: accentColor,
    foregroundColor: Colors.white,
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    extendedPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    extendedTextStyle: labelLarge.copyWith(color: Colors.white),
  );
  
  @override
  CardTheme get cardTheme => CardTheme(
    color: surfaceColor,
    elevation: 2,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
  
  @override
  DialogTheme get dialogTheme => DialogTheme(
    backgroundColor: surfaceColor,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    titleTextStyle: titleMedium,
    contentTextStyle: bodyMedium,
  );
  
  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
    backgroundColor: Color(0xFF333333),
    contentTextStyle: bodyMedium.copyWith(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    actionTextColor: secondaryColor,
  );
}
