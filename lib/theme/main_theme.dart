import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: PrimaryColors.blueAccentColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(27),
        ),
      ),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    background: PrimaryColors.darkColor,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 12,
      fontFamily: "MR",
      color: TextColors.whiteText,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontFamily: "MM",
      color: TextColors.whiteText,
    ),
    bodyLarge: TextStyle(
      fontSize: 12,
      fontFamily: "MSB",
      color: TextColors.whiteText,
    ),
  ),
);
