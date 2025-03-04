import 'package:flutter/material.dart';
import '../app_theme.dart';

class ModernExplorerTheme extends AppTheme {
  // Theme identification
  @override
  String get name => 'Modern Explorer';
  
  @override
  String get description => 'A clean, modern approach that balances outdoor aesthetics with modern UI principles';
  
  // Base Colors
  final Color _primaryLight = const Color(0xFF1D5B79); // Deep blue
  final Color _primaryDark = const Color(0xFF023E8A);
  final Color _secondaryLight = const Color(0xFF00B4D8); // Vibrant cyan
  final Color _secondaryDark = const Color(0xFF0096C7);
  final Color _accentLight = const Color(0xFFF8961E); // Bright orange
  final Color _accentDark = const Color(0xFFF77F00);
  
  final Color _backgroundLight = const Color(0xFFF8F9FA);
  final Color _backgroundDark = const Color(0xFF0A1929);
  final Color _surfaceLight = const Color(0xFFFFFFFF);
  final Color _surfaceDark = const Color(0xFF132F4C);
  
  final Color _errorLight = const Color(0xFFEF476F);
  final Color _errorDark = const Color(0xFFE63956);
  final Color _successLight = const Color(0xFF06D6A0);
  final Color _successDark = const Color(0xFF03B585);
  final Color _warningLight = const Color(0xFFFFD166);
  final Color _warningDark = const Color(0xFFE5BC5C);
  final Color _infoLight = const Color(0xFF118AB2);
  final Color _infoDark = const Color(0xFF0F79A8);

  // Font family
  final String _fontFamily = 'Inter';

  @override
  ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      colorScheme: ColorScheme.light(
        primary: _primaryLight,
        secondary: _secondaryLight,
        tertiary: _accentLight,
        background: _backgroundLight,
        surface: _surfaceLight,
        error: _errorLight,
      ),
      primaryColor: _primaryLight,
      scaffoldBackgroundColor: _backgroundLight,
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: _surfaceLight,
        foregroundColor: _primaryLight,
        elevation: 0,
      ),
      textTheme: _buildTextTheme(baseTheme.textTheme, Colors.black87),
      buttonTheme: ButtonThemeData(
        buttonColor: _primaryLight,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      cardTheme: cardTheme,
      bottomNavigationBarTheme: bottomNavBarTheme.copyWith(
        backgroundColor: _surfaceLight,
        selectedItemColor: _primaryLight,
        unselectedItemColor: Colors.black38,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _secondaryLight),
        ),
        labelStyle: TextStyle(color: Colors.black54),
        hintStyle: TextStyle(color: Colors.black38),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButtonStyle,
      ),
      textButtonTheme: TextButtonThemeData(
        style: textButtonStyle,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: secondaryButtonStyle,
      ),
      tabBarTheme: tabBarTheme.copyWith(
        labelColor: _primaryLight,
        unselectedLabelColor: Colors.black38,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.black12,
        thickness: 1,
        space: 24,
      ),
      checkboxTheme: checkboxTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      floatingActionButtonTheme: fabTheme.copyWith(
        backgroundColor: _secondaryLight,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: _secondaryLight,
        circularTrackColor: _secondaryLight.withOpacity(0.2),
      ),
      snackBarTheme: snackBarTheme,
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[100]!,
        disabledColor: Colors.grey[200]!,
        selectedColor: _primaryLight.withOpacity(0.15),
        secondarySelectedColor: _secondaryLight.withOpacity(0.15),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: TextStyle(color: Colors.black87),
        secondaryLabelStyle: TextStyle(color: _secondaryLight),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
  
  @override
  ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      colorScheme: ColorScheme.dark(
        primary: _primaryDark,
        secondary: _secondaryDark,
        tertiary: _accentDark,
        background: _backgroundDark,
        surface: _surfaceDark,
        error: _errorDark,
      ),
      primaryColor: _primaryDark,
      scaffoldBackgroundColor: _backgroundDark,
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: _surfaceDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: _buildTextTheme(baseTheme.textTheme, Colors.white),
      buttonTheme: ButtonThemeData(
        buttonColor: _primaryDark,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      cardTheme: cardTheme.copyWith(
        color: _surfaceDark,
      ),
      bottomNavigationBarTheme: bottomNavBarTheme.copyWith(
        backgroundColor: _surfaceDark,
        selectedItemColor: _secondaryDark,
        unselectedItemColor: Colors.white70,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceDark.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _secondaryDark),
        ),
        labelStyle: TextStyle(color: Colors.white70),
        hintStyle: TextStyle(color: Colors.white38),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _primaryDark,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _secondaryDark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _secondaryDark,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          side: BorderSide(color: _secondaryDark),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      tabBarTheme: tabBarTheme.copyWith(
        labelColor: _secondaryDark,
        unselectedLabelColor: Colors.white54,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white12,
        thickness: 1,
        space: 24,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      floatingActionButtonTheme: fabTheme.copyWith(
        backgroundColor: _secondaryDark,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: _surfaceDark.withOpacity(0.5),
        disabledColor: _surfaceDark.withOpacity(0.3),
        selectedColor: _primaryDark.withOpacity(0.3),
        secondarySelectedColor: _secondaryDark.withOpacity(0.3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: TextStyle(color: Colors.white),
        secondaryLabelStyle: TextStyle(color: _secondaryDark),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      displayMedium: base.displayMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      displaySmall: base.displaySmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontSize: 16,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontSize: 14,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor.withOpacity(0.8),
        fontSize: 12,
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      labelMedium: base.labelMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      labelSmall: base.labelSmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor.withOpacity(0.7),
        fontWeight: FontWeight.w500,
        fontSize: 11,
      ),
    );
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
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );
  
  @override
  TextStyle get headlineMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );
  
  @override
  TextStyle get headlineSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  
  @override
  TextStyle get titleLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  
  @override
  TextStyle get titleMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
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
    letterSpacing: 0.75,
  );
  
  @override
  TextStyle get labelMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  
  @override
  TextStyle get labelSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Widget decoration
  @override
  BoxDecoration get cardDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: Offset(0, 2),
      ),
    ],
  );
  
  @override
  BoxDecoration get dialogDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ],
  );
  
  @override
  BoxDecoration get bottomSheetDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 12,
        offset: Offset(0, -5),
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
      fillColor: Colors.grey[50],
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: secondaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor, width: 1.5),
      ),
      labelStyle: bodyMedium.copyWith(color: Colors.black54),
      hintStyle: bodyMedium.copyWith(color: Colors.black38),
      errorStyle: bodySmall.copyWith(color: errorColor),
    );
  }

  @override
  ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    textStyle: labelLarge.copyWith(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 0,
  );
  
  @override
  ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    side: BorderSide(color: primaryColor),
    textStyle: labelLarge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
  
  @override
  ButtonStyle get textButtonStyle => TextButton.styleFrom(
    foregroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textStyle: labelLarge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  // Navigation styling
  @override
  BottomNavigationBarThemeData get bottomNavBarTheme => BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: surfaceColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.black38,
    selectedLabelStyle: labelSmall,
    unselectedLabelStyle: labelSmall,
    elevation: 4,
    showUnselectedLabels: true,
  );
  
  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: surfaceColor,
    foregroundColor: primaryColor,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: titleMedium.copyWith(color: primaryColor),
    iconTheme: IconThemeData(color: primaryColor),
    actionsIconTheme: IconThemeData(color: primaryColor),
    toolbarHeight: 64,
  );
  
  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
    labelColor: primaryColor,
    unselectedLabelColor: Colors.black38,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: labelLarge.copyWith(fontWeight: FontWeight.w600),
    unselectedLabelStyle: labelLarge.copyWith(fontWeight: FontWeight.w400),
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 3.0, color: secondaryColor),
      ),
    ),
  );
  
  // Form elements
  @override
  CheckboxThemeData get checkboxTheme => CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return secondaryColor;
      }
      return Colors.transparent;
    }),
    checkColor: MaterialStateProperty.all(Colors.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    side: BorderSide(color: Colors.grey.shade400, width: 1.5),
  );
  
  @override
  RadioThemeData get radioTheme => RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return secondaryColor;
      }
      return Colors.grey.shade400;
    }),
  );
  
  @override
  SwitchThemeData get switchTheme => SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return secondaryColor;
      }
      return Colors.grey.shade400;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return secondaryColor.withOpacity(0.3);
      }
      return Colors.grey.shade300;
    }),
  );
  
  @override
  SliderThemeData get sliderTheme => SliderThemeData(
    activeTrackColor: secondaryColor,
    inactiveTrackColor: Colors.grey.shade300,
    thumbColor: secondaryColor,
    overlayColor: secondaryColor.withOpacity(0.1),
    valueIndicatorColor: secondaryColor,
    valueIndicatorTextStyle: labelMedium.copyWith(color: Colors.white),
    showValueIndicator: ShowValueIndicator.always,
    trackHeight: 4,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
  );
  
  // Additional elements
  @override
  FloatingActionButtonThemeData get fabTheme => FloatingActionButtonThemeData(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    elevation: 4,
    splashColor: secondaryColor.withOpacity(0.4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    extendedPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    extendedTextStyle: labelLarge.copyWith(color: Colors.white),
  );
  
  @override
  CardTheme get cardTheme => CardTheme(
    color: surfaceColor,
    elevation: 1,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
  
  @override
  DialogTheme get dialogTheme => DialogTheme(
    backgroundColor: surfaceColor,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    titleTextStyle: titleMedium,
    contentTextStyle: bodyMedium,
  );
  
  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
    backgroundColor: Colors.grey.shade900,
    contentTextStyle: bodyMedium.copyWith(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    actionTextColor: secondaryColor,
    elevation: 4,
  );
}
