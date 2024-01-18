import 'dart:ui';

import 'package:flutter/material.dart';

import 'colors.dart';


class AppTextStyles {
  AppTextStyles._();

  static bool isResident = false;

  // mapping XD -> wanted size.
  static const double fontSize_08 = 8;
  static const double fontSize_09 = 9;
  static const double fontSize_10 = 10;
  static const double fontSize_11 = 11;
  static const double fontSize_12 = 12;
  static const double fontSize_13 = 13;
  static const double fontSize_14 = 14;
  static const double fontSize_15 = 15;
  static const double fontSize_16 = 16;
  static const double fontSize_17 = 17;
  static const double fontSize_18 = 18;
  static const double fontSize_20 = 20;
  static const double fontSize_21 = 21;
  static const double fontSize_22 = 22;
  static const double fontSize_23 = 23;
  static const double fontSize_24 = 24;
  static const double fontSize_28 = 28;
  static const double fontSize_30 = 30;
  static const double fontSize_29 = 29;
  static const double fontSize_32 = 32;
  static const double fontSize_37 = 37;
  static const double fontSize_38 = 38;
  static const double fontSize_40 = 40;
  static const double fontSize_48 = 48;

  static TextStyle defaultRegular = TextStyle(
    color: AppColors.text,
    fontWeight: FontWeight.w400,
    fontSize: isResident ? fontSize_17 : fontSize_14,
    fontFeatures: const [
      FontFeature.tabularFigures(),
    ],
  );

  static final TextStyle defaultMedium = defaultRegular.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle defaultBold = defaultRegular.copyWith(
    fontWeight: FontWeight.w700,
  );
}
