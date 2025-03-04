import 'package:flutter/material.dart';
import '../app_theme.dart';

class CommunityAdventureTheme extends AppTheme {
  // Theme identification
  @override
  String get name => 'Community Adventure';
  
  @override
  String get description => 'A warm, inviting theme focused on social and community aspects';
  
  // Base Colors
  final Color _primaryLight = const Color(0xFFA63A50); // Warm red
  final Color _primaryDark = const Color(0xFF8E2D40);
  final Color _secondaryLight = const Color(0xFFF9A826); // Golden yellow
  final Color _secondaryDark = const Color(0xFFE09416);
  final Color _accentLight = const Color(0xFF5D9A75); // Forest green
  final Color _accentDark = const Color(0xFF4F8A65);
  
  final Color _backgroundLight = const Color(0xFFFAF5F0); // Soft cream
  final Color _backgroundDark = const Color(0xFF302C2E);
  final Color _surfaceLight = const Color(0xFFFFFFFF);
  final Color _surfaceDark = const Color(0xFF403A3E);
  
  final Color _errorLight = const Color(0xFFDA394D);
  final Color _errorDark = const Color(0xFFEF5350);
  final Color _successLight = const Color(0xFF5DAE49);
  final Color _successDark = const Color(0xFF66BB6A);
  final Color _warningLight = const Color(0xFFFFB84D);
  final Color _warningDark = const Color(0xFFFFCC80);
  final Color _infoLight = const Color(0xFF2196F3);
  final Color _infoDark = const Color(0xFF64B5F6);

  // Font family
  final String _fontFamily = 'Nunito';

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
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      cardTheme: cardTheme,
      bottomNavigationBarTheme: bottomNavBarTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _primaryLight),
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
        space: 16,
      ),
      checkboxTheme: checkboxTheme,
      radioTheme: radioTheme,
      switchTheme: switchTheme,
      sliderTheme: sliderTheme,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: _primaryLight,
        circularTrackColor: _primaryLight.withOpacity(0.2),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade200,
        disabledColor: Colors.grey.shade300,
        selectedColor: _primaryLight.withOpacity(0.15),
        secondarySelectedColor: _secondaryLight.withOpacity(0.15),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        labelStyle: TextStyle(color: Colors.black87),
        secondaryLabelStyle: TextStyle(color: _primaryLight),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
          borderRadius: BorderRadius.circular(16),
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
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _secondaryDark),
        ),
        labelStyle: TextStyle(color: Colors.white70),
        hintStyle: TextStyle(color: Colors.white38),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: _primaryDark,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _secondaryDark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _secondaryDark,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          side: BorderSide(color: _secondaryDark),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      tabBarTheme: tabBarTheme.copyWith(
        labelColor: _secondaryDark,
        unselectedLabelColor: Colors.white70,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white12,
        thickness: 1,
        space: 16,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Color(0xFF505050),
        disabledColor: Color(0xFF404040),
        selectedColor: _primaryDark.withOpacity(0.3),
        secondarySelectedColor: _secondaryDark.withOpacity(0.3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        labelStyle: TextStyle(color: Colors.white),
        secondaryLabelStyle: TextStyle(color: _secondaryDark),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
      ),
      headlineMedium: base.headlineMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w700,
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
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: base.bodyMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: base.bodySmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor.withOpacity(0.8),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      labelMedium: base.labelMedium!.copyWith(
        fontFamily: _fontFamily,
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      labelSmall: base.labelSmall!.copyWith(
        fontFamily: _fontFamily,
        color: textColor.withOpacity(0.7),
        fontWeight: FontWeight.w600,
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
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  
  @override
  TextStyle get titleMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  
  @override
  TextStyle get titleSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );
  
  @override
  TextStyle get bodyLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );
  
  @override
  TextStyle get bodyMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );
  
  @override
  TextStyle get bodySmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
  );
  
  @override
  TextStyle get labelLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  @override
  TextStyle get labelMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  @override
  TextStyle get labelSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Widget decoration
  @override
  BoxDecoration get cardDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  );
  
  @override
  BoxDecoration get dialogDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 12,
        offset: Offset(0, 6),
      ),
    ],
  );
  
  @override
  BoxDecoration get bottomSheetDecoration => BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 10,
        offset: Offset(0, -4),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primaryColor),
      ),
      labelStyle: bodyMedium.copyWith(color: Colors.black87),
      hintStyle: bodyMedium.copyWith(color: Colors.black38),
      errorStyle: bodySmall.copyWith(color: errorColor),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: errorColor, width: 1.5),
      ),
    );
  }

  @override
  ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    textStyle: labelLarge.copyWith(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 2,
  );
  
  @override
  ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    side: BorderSide(color: primaryColor, width: 1.5),
    textStyle: labelLarge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
  
  @override
  ButtonStyle get textButtonStyle => TextButton.styleFrom(
    foregroundColor: primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textStyle: labelLarge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  // Navigation styling
  @override
  BottomNavigationBarThemeData get bottomNavBarTheme => BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: surfaceColor,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: labelSmall,
    unselectedLabelStyle: labelSmall,
    elevation: 10,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );
  
  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    backgroundColor: surfaceColor,
    foregroundColor: primaryColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: titleMedium.copyWith(color: primaryColor),
    iconTheme: IconThemeData(color: primaryColor),
    toolbarHeight: 60,
  );
  
  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
    labelColor: primaryColor,
    unselectedLabelColor: Colors.grey,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: labelLarge.copyWith(fontWeight: FontWeight.w700),
    unselectedLabelStyle: labelLarge.copyWith(fontWeight: FontWeight.w500),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(width: 3.0, color: primaryColor),
      insets: EdgeInsets.symmetric(horizontal: 16.0),
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    side: BorderSide(color: Colors.grey.shade400, width: 1.5),
  );
  
  @override
  RadioThemeData get radioTheme => RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return Colors.grey.shade400;
    }),
    splashRadius: 20,
  );
  
  @override
  SwitchThemeData get switchTheme => SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return Colors.grey.shade400;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor.withOpacity(0.4);
      }
      return Colors.grey.shade300;
    }),
  );
  
  @override
  SliderThemeData get sliderTheme => SliderThemeData(
    activeTrackColor: primaryColor,
    inactiveTrackColor: Colors.grey.shade300,
    thumbColor: secondaryColor,
    overlayColor: secondaryColor.withOpacity(0.2),
    valueIndicatorColor: primaryColor,
    valueIndicatorTextStyle: labelMedium.copyWith(color: Colors.white),
    showValueIndicator: ShowValueIndicator.always,
    trackHeight: 4,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
  );
  
  // Additional elements
  @override
  FloatingActionButtonThemeData get fabTheme => FloatingActionButtonThemeData(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    extendedPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    extendedTextStyle: labelLarge.copyWith(color: Colors.white),
  );
  
  @override
  CardTheme get cardTheme => CardTheme(
    color: surfaceColor,
    elevation: 2,
    margin: EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    clipBehavior: Clip.antiAlias,
  );
  
  @override
  DialogTheme get dialogTheme => DialogTheme(
    backgroundColor: surfaceColor,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    titleTextStyle: titleMedium,
    contentTextStyle: bodyMedium,
  );
  
  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
    backgroundColor: Color(0xFF505050),
    contentTextStyle: bodyMedium.copyWith(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    actionTextColor: secondaryColor,
    elevation: 4,
  );
}
