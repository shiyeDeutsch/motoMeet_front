import 'package:flutter/material.dart';
import '../app_theme.dart';

class TechnicalEquipmentTheme extends AppTheme {
  // Theme identification
  @override
  String get name => 'Technical Equipment';
  
  @override
  String get description => 'A theme inspired by high-end outdoor and motorcycle gear';
  
  // Base Colors
  final Color _primaryLight = const Color(0xFF212529); // Carbon black
  final Color _primaryDark = const Color(0xFF121416);
  final Color _secondaryLight = const Color(0xFFFA6B39); // Vibrant orange
  final Color _secondaryDark = const Color(0xFFE05829);
  final Color _accentLight = const Color(0xFF31A9B8); // Teal
  final Color _accentDark = const Color(0xFF2191A0);
  
  final Color _backgroundLight = const Color(0xFFF8F9FA);
  final Color _backgroundDark = const Color(0xFF1D1F21);
  final Color _surfaceLight = const Color(0xFFFFFFFF);
  final Color _surfaceDark = const Color(0xFF2C2E30);
  
  final Color _errorLight = const Color(0xFFE03131);
  final Color _errorDark = const Color(0xFFFF6B6B);
  final Color _successLight = const Color(0xFF2B8A3E);
  final Color _successDark = const Color(0xFF51CF66);
  final Color _warningLight = const Color(0xFFE67700);
  final Color _warningDark = const Color(0xFFFFD43B);
  final Color _infoLight = const Color(0xFF1971C2);
  final Color _infoDark = const Color(0xFF339AF0);

  // Font family
  final String _fontFamily = 'Roboto Condensed';

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
      appBarTheme: appBarTheme,
      textTheme: _buildTextTheme(baseTheme.textTheme, Colors.black87),
      buttonTheme: ButtonThemeData(
        buttonColor: _primaryLight,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      cardTheme: cardTheme,
      bottomNavigationBarTheme: bottomNavBarTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: _secondaryLight),
        ),
        labelStyle: TextStyle(color: Colors.black87),
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
      tabBarTheme: tabBarTheme,
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade300,
        thickness: 1,
        space: 1,
      ),
      checkboxTheme: checkboxTheme,
      radioTheme: radioTheme,
      switchTheme: switchTheme,
      sliderTheme: sliderTheme,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: _secondaryLight,
        circularTrackColor: _secondaryLight.withOpacity(0.2),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade200,
        disabledColor: Colors.grey.shade300,
        selectedColor: _secondaryLight.withOpacity(0.15),
        secondarySelectedColor: _secondaryLight.withOpacity(0.3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: TextStyle(color: Colors.black87),
        secondaryLabelStyle: TextStyle(color: _secondaryLight),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
      dialogTheme: dialogTheme,
      floatingActionButtonTheme: fabTheme,
      snackBarTheme: snackBarTheme,
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
        backgroundColor: _primaryDark,
        foregroundColor: Colors.white,
      ),
      textTheme: _buildTextTheme(baseTheme.textTheme, Colors.white),
      buttonTheme: ButtonThemeData(
        buttonColor: _primaryDark,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
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
        fillColor: _surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: _secondaryDark),
        ),
        labelStyle: TextStyle(color: Colors.white70),
        hintStyle: TextStyle(color: Colors.white38),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _primaryDark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _secondaryDark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _secondaryDark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          side: BorderSide(color: _secondaryDark),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
      tabBarTheme: tabBarTheme.copyWith(
        labelColor: _secondaryDark,
        unselectedLabelColor: Colors.white70,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white24,
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Color(0xFF3A3A3C),
        disabledColor: Color(0xFF2C2C2E),
        selectedColor: _secondaryDark.withOpacity(0.2),
        secondarySelectedColor: _secondaryDark.withOpacity(0.4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: TextStyle(color: Colors.white),
        secondaryLabelStyle: TextStyle(color: _secondaryDark),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
      dialogTheme: dialogTheme.copyWith(
        backgroundColor: _surfaceDark,
      ),
      floatingActionButtonTheme: fabTheme.copyWith(
        backgroundColor: _secondaryDark,
      ),
      snackBarTheme: snackBarTheme.copyWith(
        backgroundColor: Color(0xFF3A3A3C),
        actionTextColor: _secondaryDark,
      ),
    );
  }

  TextTheme _buildTextTheme(TextTheme base, Color textColor) {
    return base.copyWith(
      displayLarge: base.displayLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w300,
      ),
      displayMedium: base.displayMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w300,
      ),
      displaySmall: base.displaySmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineSmall: base.headlineSmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: base.titleLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: base.titleMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: base.bodyLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor.withOpacity(0.8),
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: base.labelMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
      labelSmall: base.labelSmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor.withOpacity(0.7),
        fontWeight: FontWeight.w700,
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
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );
  
  @override
  TextStyle get headlineMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );
  
  @override
  TextStyle get headlineSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  
  @override
  TextStyle get titleLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  
  @override
  TextStyle get titleMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
  );
  
  @override
  TextStyle get titleSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
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
    fontWeight: FontWeight.w700,
    letterSpacing: 0.75,
  );
  
  @override
  TextStyle get labelMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );
  
  @override
  TextStyle get labelSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  // Widget decoration
  @override
  BoxDecoration get cardDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 4,
        offset: Offset(0, 1),
      ),
    ],
    image: DecorationImage(
      image: AssetImage('assets/images/carbon_fiber.png'),
      fit: BoxFit.cover,
      opacity: 0.03,
    ),
  );
  
  @override
  BoxDecoration get dialogDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(2),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  );
  
  @override
  BoxDecoration get bottomSheetDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 4,
        offset: Offset(0, -1),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: secondaryColor),
      ),
      labelStyle: bodyMedium.copyWith(fontWeight: FontWeight.w500),
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
      borderRadius: BorderRadius.circular(2),
    ),
    elevation: 0,
  );
  
  @override
  ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    side: BorderSide(color: primaryColor, width: 1),
    textStyle: labelLarge.copyWith(fontWeight: FontWeight.w700),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    ),
  );
  
  @override
  ButtonStyle get textButtonStyle => TextButton.styleFrom(
    foregroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    textStyle: labelLarge.copyWith(fontWeight: FontWeight.w700),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    ),
  );

  // Navigation styling
  @override
  BottomNavigationBarThemeData get bottomNavBarTheme => BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: surfaceColor,
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.black54,
    selectedLabelStyle: labelSmall,
    unselectedLabelStyle: labelSmall,
    elevation: 8,
    showUnselectedLabels: true,
  );
  
  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: titleMedium.copyWith(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    toolbarHeight: 56,
  );
  
  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
    labelColor: secondaryColor,
    unselectedLabelColor: Colors.black54,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: labelLarge.copyWith(fontWeight: FontWeight.w700),
    unselectedLabelStyle: labelLarge.copyWith(fontWeight: FontWeight.w400),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(width: 2.0, color: secondaryColor),
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    side: BorderSide(color: Colors.grey.shade600, width: 1.5),
  );
  
  @override
  RadioThemeData get radioTheme => RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return secondaryColor;
      }
      return Colors.grey.shade600;
    }),
  );
  
  @override
  SwitchThemeData get switchTheme => SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return secondaryColor;
      }
      return Colors.grey;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return secondaryColor.withOpacity(0.3);
      }
      return Colors.grey.withOpacity(0.3);
    }),
  );
  
  @override
  SliderThemeData get sliderTheme => SliderThemeData(
    activeTrackColor: secondaryColor,
    inactiveTrackColor: Colors.grey.shade300,
    thumbColor: secondaryColor,
    overlayColor: secondaryColor.withOpacity(0.1),
    valueIndicatorColor: primaryColor,
    valueIndicatorTextStyle: labelSmall.copyWith(color: Colors.white),
    showValueIndicator: ShowValueIndicator.always,
    trackHeight: 2,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
  );
  
  // Additional elements
  @override
  FloatingActionButtonThemeData get fabTheme => FloatingActionButtonThemeData(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    elevation: 2,
    highlightElevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    ),
    extendedPadding: EdgeInsets.symmetric(horizontal: 16),
    extendedTextStyle: labelLarge.copyWith(color: Colors.white),
  );
  
  @override
  CardTheme get cardTheme => CardTheme(
    color: surfaceColor,
    elevation: 1,
    margin: EdgeInsets.all(4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    ),
    clipBehavior: Clip.antiAlias,
  );
  
  @override
  DialogTheme get dialogTheme => DialogTheme(
    backgroundColor: surfaceColor,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    ),
    titleTextStyle: titleMedium,
    contentTextStyle: bodyMedium,
  );
  
  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
    backgroundColor: Colors.grey.shade900,
    contentTextStyle: bodyMedium.copyWith(color: Colors.white),
    behavior: SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    actionTextColor: secondaryColor,
    elevation: 2,
  );
}
