import 'package:flutter/material.dart';

ThemeData draculaTheme = ThemeData(
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        width: 1.3,
        color: Color(0xffbd93f9),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffbd93f9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(27),
        ),
      ),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    background: Color(0xff282a36),
    primary: Color(0xffbd93f9),
    primaryContainer: Color(0xff44475a),
    secondaryContainer: Color(0xffffb86c),
    secondary: Color(0xff6272a4),
    tertiary: Color(0xfff8f8f2),
  ),
);


// primary container for dividers
// secondary container for yellow buttons 
// primary for most icons
// tertiary for light texts
// secondary for comment container 