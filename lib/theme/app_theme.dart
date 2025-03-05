import 'package:flutter/material.dart';

Color backgroundColor = Colors.purple[100]!;
const Color titleColor = Color(0xFF353535);
const Color textColor = Color(0xFF353535);
const Color mutedIconColor = Color(0xFFA1A1A1);
const Color mutedTextColor = Color(0xFF919191);
const Color inputBackgroundColor = Color(0xFFF1F1F1);
const Color cardBackgroundColor = Color(0xFFF0F0F0);
const Color cardBorderColor = Color(0xFFD8D8D8);
const Color cardFocusBorderColor = Color.fromARGB(255, 203, 203, 203);
const Color iconColor = Color(0xFF515866);
// Primary color (Blue): Used for key interactive elements like buttons, links, and selected states
const Color primaryColor = Colors.purple;
const Color secondaryColor = Colors.white;

// Tertiary color (Gray): Used for less important UI elements like disabled states or subtle details
const tertiaryColor = Color(0xFFffffff);

// Accent color (Yellow): Used to highlight important information like warnings, success messages, or interactive elements
const accentColor = Color(0xFFFFD700);

// Surface color (White): Used for cards, containers, and other elevated UI elements
const surfaceColor = Color(0xFFFFFFFF);

// Error color (Red): Used to indicate errors or problems
const errorColor = Color(0xFFB00020);

// Text colors that contrast with the background colors
const onprimaryColor =
    Color(0xFFFFFFFF); // Text color used on primary (blue) color background
const onSecondaryColor =
    Color(0xFF303030); // Text color used on secondary (black) color background
const onTertiaryColor =
    Color(0xFFFFFFFF); // Text color used on tertiary (gray) color background
const onSurfaceColor =
    Color(0xFF7A7A7A); // Text color used on surface (white) color
const onErrorColor =
    Color(0xFFFFFFFF); // Text color used on error (red) color background

const Color outlineColor = Color(0xFFD7DEE0); //border color
const Color onSecondaryContainer = Color(0xFF000000); //text color
const Color shadowColor = Color.fromARGB(15, 0, 0, 0);
const Color dividerColor = Color(0xFFE6E6E6);

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: backgroundColor,
  dialogBackgroundColor: backgroundColor,
  dividerColor: dividerColor,
  dividerTheme: const DividerThemeData(
    color: dividerColor,
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(color: onSecondaryColor),
    labelMedium: TextStyle(color: onSecondaryColor),
    labelSmall: TextStyle(color: onSecondaryColor),
    titleLarge: TextStyle(color: onSecondaryColor),
    titleMedium: TextStyle(color: onSecondaryColor),
    titleSmall: TextStyle(color: onSecondaryColor),
    bodyLarge: TextStyle(color: onSecondaryColor),
    bodyMedium: TextStyle(color: onSecondaryColor),
    bodySmall: TextStyle(color: onSecondaryColor),
    headlineLarge: TextStyle(color: onSecondaryColor),
    headlineMedium: TextStyle(color: onSecondaryColor),
    headlineSmall: TextStyle(color: onSecondaryColor),
    displayLarge: TextStyle(color: onSecondaryColor),
    displayMedium: TextStyle(color: onSecondaryColor),
    displaySmall: TextStyle(color: onSecondaryColor),
  ),
  fontFamily: 'GeneralSans',
  colorScheme: const ColorScheme.light(
    primary: primaryColor, //primary color for button,text etc
    onPrimary: onprimaryColor, // text color on primary
    secondary: secondaryColor, //drawer active and table color
    onSecondary: onSecondaryColor, //color of drawer active text
    onSecondaryContainer: onSecondaryColor, //table text color
    tertiary: tertiaryColor,
    error: errorColor,
    surface: surfaceColor,
    onSurface: onSurfaceColor, //color of drawer inactive text
    outline: outlineColor, //border color
    shadow: shadowColor, //shadow color
  ),
  appBarTheme: AppBarTheme(
    color: backgroundColor,
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: iconColor,
    ),
  ),
  iconTheme: const IconThemeData(
    color: iconColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    suffixIconColor: iconColor,
    prefixIconColor: iconColor,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 12,
    ),
    fillColor: cardBackgroundColor,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: cardBorderColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: cardBorderColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: cardFocusBorderColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.red[700]!,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: cardBorderColor,
      ),
    ),
  ),
);
