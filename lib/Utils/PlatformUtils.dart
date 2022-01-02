import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  OSPlatformType getOSPlatformType() {
    if (kIsWeb) {
      return OSPlatformType.web;
    }

    if (Platform.isAndroid) {
      return OSPlatformType.android;
    }
    if (Platform.isFuchsia) {
      return OSPlatformType.fuchsia;
    }
    if (Platform.isIOS) {
      return OSPlatformType.ios;
    }
    if (Platform.isLinux) {
      return OSPlatformType.linux;
    }
    if (Platform.isMacOS) {
      return OSPlatformType.macOS;
    }
    if (Platform.isWindows) {
      return OSPlatformType.windows;
    }

    return OSPlatformType.web;
  }

  String getOSPlatformTypeAsString() {
    OSPlatformType osPlatformType = this.getOSPlatformType();
    String osType = "";
    switch (osPlatformType) {
      case OSPlatformType.android:
        osType = "android";
        break;
      case OSPlatformType.fuchsia:
        osType = "fuchsia";
        break;
      case OSPlatformType.ios:
        osType = "ios";
        break;
      case OSPlatformType.linux:
        osType = "linux";
        break;
      case OSPlatformType.macOS:
        osType = "macOS";
        break;
      case OSPlatformType.web:
        osType = "web";
        break;
      case OSPlatformType.windows:
        osType = "windows";
        break;
    }

    return osType;
  }
}

enum OSPlatformType { android, fuchsia, ios, linux, macOS, web, windows }
