import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class LogoScheme {
  static String _logoDarkMode = "assets/images/appLogoDarkMode.png";
  static String _logoLightMode = "assets/images/appLogoLightMode.png";

  static String get logoPath {
    if (SchedulerBinding.instance!.window.platformBrightness ==
        Brightness.dark) {
      return _logoDarkMode;
    }
    return _logoLightMode;
  }
}
