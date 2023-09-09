import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:study/configs/thems/sub_theme_data_minxin.dart';

const Color primaryDarkColorDark = Color(0xFF2e3c62);
const Color primaryColorDark = Color(0xFF99ace1);
const Color mainTextColor = Colors.white;


class DarkTheme with SubThemeData{
  ThemeData buildDarkTheme(){
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      primaryColor: primaryColorDark,
        iconTheme: getIconTheme(),
    textTheme: getTextThemes().apply(
    bodyColor: mainTextColor,
    displayColor: mainTextColor
    ));
  }
}