
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/colors_manager.dart';

ThemeData getAppThemeDate(){
  return ThemeData(
    primaryColor: ColorManager.primaryColor,
    primaryColorDark: ColorManager.darkPrimaryColor,
    primaryColorLight: ColorManager.lightPrimaryColor,
    disabledColor: ColorManager.grey1
  ) ;
}