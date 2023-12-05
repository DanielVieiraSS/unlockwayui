import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unlockway/constants.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(darkBgdark),
      systemNavigationBarColor: Color(darkBgdark),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(primary),
  ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(primarydark),
    background: Color(lightBg),
    onBackground: Color(lightBgdark),
    outline: Color(darkBglight),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(primary),
  ),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(primary),
    background: Color(darkBgdark),
    onBackground: Color(darkBglight),
    outline: Colors.white,
  ),
);
