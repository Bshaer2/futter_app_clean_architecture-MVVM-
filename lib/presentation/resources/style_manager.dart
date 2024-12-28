
import 'dart:ui';

import 'package:tut_app/presentation/resources/fonts_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color){
  return TextStyle(
  fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontConstants.fontFamily,
    color: color
  );
}

TextStyle getBoldTextStyle({double fontSize = FontSize.size12, required Color color }){
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

TextStyle getSemiBoldTextStyle({double fontSize = FontSize.size12, required Color color }){
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

TextStyle getMediumTextStyle({double fontSize = FontSize.size12, required Color color }){
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

TextStyle getRegularTextStyle({double fontSize = FontSize.size12, required Color color }){
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle getLightTextStyle({double fontSize = FontSize.size12, required Color color }){
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}