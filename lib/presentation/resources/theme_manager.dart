import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/colors_manager.dart';
import 'package:tut_app/presentation/resources/style_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

ThemeData getAppThemeDate() {
  return ThemeData(
      primaryColor: ColorManager.primaryColor,
      primaryColorDark: ColorManager.darkPrimaryColor,
      primaryColorLight: ColorManager.lightPrimaryColor,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.darkPrimaryColor,
      cardTheme: _cardTheme(),
      appBarTheme: _appBarTheme(),
      buttonTheme: _buttonThemeData(),
      elevatedButtonTheme: _elevatedButtonThemeData(),
      textTheme: _textTheme(),
      inputDecorationTheme: _inputDecorationTheme());
}

CardTheme _cardTheme() {
  return CardTheme(
    color: ColorManager.white,
    shadowColor: ColorManager.grey,
    elevation: AppSize.size4,
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
      centerTitle: true,
      color: ColorManager.primaryColor,
      elevation: AppSize.size4,
      shadowColor: ColorManager.lightPrimaryColor,
      titleTextStyle: getRegularTextStyle(
          fontSize: FontSize.size16, color: ColorManager.white));
}

ButtonThemeData _buttonThemeData() {
  return ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.lightGrey,
      buttonColor: ColorManager.primaryColor,
      splashColor: ColorManager.lightPrimaryColor);
}

ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(
            fontSize: FontSize.size17, color: ColorManager.white),
        foregroundColor: ColorManager.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.size12),
        )),
  );
}

TextTheme _textTheme() {
  return TextTheme(
      headlineLarge: getSemiBoldTextStyle(
          fontSize: FontSize.size22, color: ColorManager.white),
      titleMedium: getMediumTextStyle(
          fontSize: FontSize.size16, color: ColorManager.darkGrey),
      titleSmall: getRegularTextStyle(
          fontSize: FontSize.size14, color: ColorManager.lightGrey),
      bodyMedium: getRegularTextStyle(color: ColorManager.grey),
      labelSmall: getRegularTextStyle(color: ColorManager.grey1));
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    hintStyle: getRegularTextStyle(
        fontSize: FontSize.size14, color: ColorManager.grey),
    labelStyle:
        getMediumTextStyle(fontSize: FontSize.size14, color: ColorManager.grey),
    errorStyle: getRegularTextStyle(color: ColorManager.errorRedColor),
    enabledBorder: _outlineInputBorder(ColorManager.primaryColor),
    focusedBorder: _outlineInputBorder(ColorManager.grey),
    errorBorder: _outlineInputBorder(ColorManager.errorRedColor),
    focusedErrorBorder: _outlineInputBorder(ColorManager.primaryColor),
  );
}

OutlineInputBorder _outlineInputBorder(Color color) {
  return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: AppSize.size1),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSize.size8),
      ));
}
