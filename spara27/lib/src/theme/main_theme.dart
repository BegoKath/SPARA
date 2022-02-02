import 'package:flutter/material.dart';
import 'package:spara27/src/theme/colors.dart';

class AppTheme {
  static const Color colorMediumPriority = Colors.yellow;
  static const Color colorHighPriority = Colors.red;
  static final Color colorLowPriority = Colors.green.shade400;
  static final TextTheme textTheme = TextTheme(
    headline1: _headLine1,
    headline2: _headLine2,
    headline3: _headLine3,
    headline4: _headLine4,
    headline5: _headLine5,
    headline6: _headLine6,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
    subtitle1: _subTitle1,
    subtitle2: _subTitle2,
    caption: _caption,
  );

  static const TextStyle _headLine1 = TextStyle(fontFamily: 'roboto');
  static final TextStyle _headLine2 = _headLine1.copyWith();
  static final TextStyle _headLine3 = _headLine2.copyWith();
  static final TextStyle _headLine4 = _headLine3.copyWith();
  static final TextStyle _headLine5 = _headLine4.copyWith();
  static final TextStyle _headLine6 = _headLine5.copyWith();
  static final TextStyle _subTitle1 = _headLine6.copyWith();
  static final TextStyle _subTitle2 = _subTitle1.copyWith();
  static final TextStyle _bodyText1 = _subTitle2.copyWith();
  static final TextStyle _bodyText2 = _bodyText1.copyWith();
  static final TextStyle _caption = _bodyText2.copyWith();
  static ThemeData themeData(bool ligthMode) {
    return ThemeData(
      textTheme: textTheme,
      primaryColor: sparaGreen900,
      primaryColorLight: sparaGreen50,
      primaryColorDark: sparaGreen400,
      colorScheme: ColorScheme(
          primary: sparaGreen900,
          primaryVariant: sparaGreen300,
          secondary: sparaGreen100,
          secondaryVariant: sparaGreen50,
          surface: sparaGreen900,
          background: sparaGreen900,
          error: sparaErrorRed,
          onPrimary: sparaGreen400,
          onBackground: sparaGreen300,
          onSecondary: sparaGreen100,
          onSurface: sparaGreen300,
          onError: sparaErrorRed,
          brightness: ligthMode ? Brightness.dark : Brightness.light),
    );
  }
}
