import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mcn_app/routers/routers.dart';
import 'package:mcn_app/ui/splash/splash_screen.dart';
import 'package:mcn_app/utils/color.dart';
import 'package:mcn_app/utils/simple_bloc_delegate.dart';
import 'package:mcn_app/utils/ui_helper.dart';

import 'di/module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  Bloc.observer = SimpleBlocObserver();
  return runZonedGuarded(() async {
    runApp(MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, canvasColor: Colors.white),
      onGenerateRoute: (settings) => Routers.onGenerateRoute(settings),
      initialRoute: Routers.START_PAGE,
    ));
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    UiHelper.changeStatusBarColor(statusBarColor: CustomColor.PRIMARY_COLOR);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(constraints);
        return SplashScreen();
      },
    );
  }
}
