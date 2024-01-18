/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your theme, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created theme or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/theme.dart';`
library;
// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'app_text_styles.dart';
import 'colors.dart';
import 'dimens.dart';
import 'font_family.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      // useMaterial3: true,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.primary,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      fontFamily: FontFamily.inter,
      hintColor: colorScheme.surface,
      disabledColor: colorScheme.background,
      shadowColor: colorScheme.shadow,
      dividerColor: colorScheme.onSurface,
      buttonTheme:
          ButtonThemeData(disabledColor: colorScheme.onSecondaryContainer),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.dimens_16),
            topRight: Radius.circular(Dimens.dimens_16),
          ),
        ),
      ),
    );
  }

  /// Light mode hiện tại chưa đúng
  /// ==> Dùng color scheme của dark bên dưới
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: AppColors.redD84141,
    onPrimary: _darkFillColor,
    primaryContainer: AppColors.redF3C8C8,
    onPrimaryContainer: AppColors.redFF7B7B,
    onInverseSurface: AppColors.redFF5252,
    onSecondaryContainer: AppColors.redC8160C,
    onTertiary: AppColors.red560D0D,
    surfaceVariant: AppColors.white,
    onSurfaceVariant: AppColors.greyCACACA,
    onTertiaryContainer: AppColors.grey969696,
    surfaceTint: AppColors.black393939,
    outlineVariant: AppColors.black272222,
    tertiary: AppColors.black1E1919,
    surface: AppColors.white,
    onSurface: AppColors.whiteE3E3E3,
    secondary: AppColors.yellowECC53B,
    onSecondary: _darkFillColor,
    inversePrimary: AppColors.pinkD84193,
    inverseSurface: AppColors.purpleB141D8,
    secondaryContainer: AppColors.green56D841,
    outline: AppColors.blue41B4D8,

    shadow: AppColors.white,
    // White with 0.05 opacity
    error: AppColors.redC8160C,
    onError: _darkFillColor,

    background: AppColors.whiteE3E3E3,
    onBackground: AppColors.black191919,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: AppColors.redD84141,
    onPrimary: _darkFillColor,
    primaryContainer: AppColors.redF3C8C8,
    onPrimaryContainer: AppColors.redFF7B7B,
    onInverseSurface: AppColors.redFF5252,
    onSecondaryContainer: AppColors.redC8160C,
    onTertiary: AppColors.red560D0D,
    surfaceVariant: AppColors.white,
    onSurfaceVariant: AppColors.greyCACACA,
    onTertiaryContainer: AppColors.grey969696,
    surfaceTint: AppColors.black393939,
    outlineVariant: AppColors.black272222,
    background: AppColors.black1E1919,
    surface: AppColors.black111111,
    inverseSurface: AppColors.purpleB141D8,
    inversePrimary: AppColors.pinkD84193,
    secondaryContainer: AppColors.green56D841,
    secondary: AppColors.yellowECC53B,
    onSecondary: _darkFillColor,
    outline: AppColors.blue41B4D8,

    shadow: AppColors.greyE5E5E5,
    // White with 0.05 opacity
    error: AppColors.redC8160C,
    onError: _darkFillColor,

    onBackground: AppColors.whiteE3E3E3,
    onSurface: AppColors.whiteE3E3E3,
    brightness: Brightness.dark,
  );

  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;

  static const TextTheme _textTheme = TextTheme(
    titleLarge: TextStyle(fontSize: AppTextStyles.fontSize_20),
    titleMedium: TextStyle(fontSize: AppTextStyles.fontSize_16),
    titleSmall: TextStyle(fontSize: AppTextStyles.fontSize_14),
    bodyLarge: TextStyle(fontSize: AppTextStyles.fontSize_16),
    bodyMedium: TextStyle(fontSize: AppTextStyles.fontSize_14),
    bodySmall: TextStyle(fontSize: AppTextStyles.fontSize_13),
    labelLarge: TextStyle(fontSize: AppTextStyles.fontSize_20),
    labelMedium: TextStyle(fontSize: AppTextStyles.fontSize_16),
    labelSmall: TextStyle(fontSize: AppTextStyles.fontSize_14),
    displayLarge: TextStyle(fontSize: AppTextStyles.fontSize_40),
    displayMedium: TextStyle(fontSize: AppTextStyles.fontSize_32),
    displaySmall: TextStyle(fontSize: AppTextStyles.fontSize_24),
    headlineMedium: TextStyle(fontSize: AppTextStyles.fontSize_20),
    headlineSmall: TextStyle(fontSize: AppTextStyles.fontSize_16),
  );
}
