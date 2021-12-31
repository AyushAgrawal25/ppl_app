import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppColorScheme {
  // BG Color TIll u got a way to set the issue with materil app scaffold bg color
  static Color bgColorLightMode = Color.fromRGBO(250, 250, 250, 1);
  static Color bgColorDarkMode = Color.fromRGBO(18, 18, 18, 1);
  static Color get bgColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return bgColorDarkMode;
    }
    return bgColorLightMode;
  }

  // Theme Colors
  static Color themeColor = Color.fromRGBO(11, 194, 153, 1);
  // TODO:Create getter for theme Color

  // Text Color
  static Color _textColorLightMode = Color(0xFF3E3E3E);
  static Color _textColorDarkMode = Color.fromRGBO(200, 200, 200, 1);

  static Color get textColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _textColorDarkMode;
    }
    return _textColorLightMode;
  }

  // Red Color
  static Color _redColorLightMode = Colors.red;
  static Color _redColorDarkMode = Colors.redAccent;

  static Color get redColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _redColorDarkMode;
    }
    return _redColorLightMode;
  }

  // Details Color
  // Light Detail Color
  static Color _lightDetailColorLightMode = Color.fromRGBO(100, 100, 100, 1);
  static Color _lightDetailColorDarkMode = Color.fromRGBO(155, 155, 155, 1);
  static Color get lightDetailColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _lightDetailColorDarkMode;
    }
    return _lightDetailColorLightMode;
  }

  // Dark Detail Color
  static Color _darkDetailColorLightMode = Color.fromRGBO(50, 50, 50, 1);
  static Color _darkDetailColorDarkMode = Color.fromRGBO(205, 205, 205, 1);
  static Color get darkDetailColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _darkDetailColorDarkMode;
    }
    return _darkDetailColorLightMode;
  }

  // Divider Color
  // Light Divider Color
  static Color _lightDividerColorLightMode = Color.fromRGBO(225, 225, 225, 1);
  static Color _lightDividerColorDarkMode = Color.fromRGBO(30, 30, 30, 1);
  static Color get lightDividerColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _lightDividerColorDarkMode;
    }
    return _lightDividerColorLightMode;
  }

  // Dark Divider Color
  static Color _darkDividerColorLightMode = Color.fromRGBO(180, 180, 180, 1);
  static Color _darkDividerColorDarkMode = Color.fromRGBO(75, 75, 75, 1);
  static Color get darkDividerColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _darkDividerColorDarkMode;
    }
    return _darkDividerColorLightMode;
  }

  // Error Color
  static Color lightErrorGreyColor = Color.fromRGBO(150, 150, 150, 1);

  // Shadow Colors
  // Light Shadow Color
  static Color _lightShadowColorLightMode = Color.fromRGBO(255, 255, 255, 0.3);
  static Color _lightShadowColorDarkMode = Color.fromRGBO(0, 0, 0, 0.3);
  static Color get lightShadowColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _lightShadowColorDarkMode;
    }
    return _lightShadowColorLightMode;
  }

  // Dark Shadow Color
  static Color _darkShadowColorLightMode = Color.fromRGBO(0, 0, 0, 0.04);
  static Color _darkShadowColorDarkMode = Color.fromRGBO(0, 0, 0, 0.125);
  static Color get darkShadowColor {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _darkShadowColorDarkMode;
    }
    return _darkShadowColorLightMode.withOpacity(0.04);
  }
}
