import 'package:flutter/material.dart';

final primaryColor = Color(0xFF366CF6).withOpacity(0.8);
final secondaryColor = Colors.white;
const kBgLightColor = Color(0xFFF2F4FC);
const kBgDarkColor = Color(0xFFEBEDFA);
const kGrayColor = Color(0xFF8793B2);
const kTextColor = Color(0xFF4D5875);
const kDefaultPadding = 20.0;

final appTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    secondaryHeaderColor: secondaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
    ),
    textTheme: TextTheme().copyWith(bodyText1: TextStyle(color: Colors.black)),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: Colors.grey),
        iconColor: primaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )));
