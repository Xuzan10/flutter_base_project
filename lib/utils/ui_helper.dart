import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcn_app/constants/color.dart';

class UiHelper {
  static showSnackBar(context, String message, {bool isError = false}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.black,
      content: Text(
        message,
      ),
    ));
  }

  static changeStatusBarColor({Color? statusBarColor}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? CustomColor.PRIMARY_COLOR,
        systemNavigationBarColor: Colors.black));
  }

  static setPortraitOrientationOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  static setLandscapeOrientationOnly() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  static resetOrientations() {
    setPortraitOrientationOnly();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}
