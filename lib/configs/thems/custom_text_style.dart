import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study/configs/thems/app_colors.dart';
import 'package:study/configs/thems/ui_parameters.dart';

TextStyle cardTitles(context) => TextStyle(
    color: UIParameters.isDarkMode()
        ? Theme.of(context).textTheme.bodyText1!.color
        : Theme.of(context).primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold);

const detailText = TextStyle(fontSize: 12);
const headerText = TextStyle(fontSize: 22, fontWeight:  FontWeight.w700, color: onSurfaceTextColor);
const questionTS = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);

const appBarTs = TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color:  onSurfaceTextColor);

TextStyle countDownTimerTS() => TextStyle(
    letterSpacing: 2,
    color: UIParameters.isDarkMode()?Theme.of(Get.context!).textTheme.bodyText1!.color:Theme.of(Get.context!).primaryColor
);