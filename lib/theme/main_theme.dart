import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        width: 1.3,
        color: PrimaryColors.blueAccentColor,
      ),
    ),
  ),
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
    primary: PrimaryColors.blueAccentColor,
    primaryContainer: Color(0xff252836),
    secondaryContainer: SecondaryColors.orangeColor,
    secondary: PrimaryColors.softColor,
    tertiary: TextColors.whiteText,
    tertiaryContainer: SecondaryColors.redColor,
    surfaceVariant: SecondaryColors.greenColor,
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



// primary container for dividers
// secondary container for yellow buttons 
// primary for most icons
// tertiary for light texts
// secondary for comment container 