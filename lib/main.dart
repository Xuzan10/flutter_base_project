import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mcn_app/bloc/authentication/authentication_cubit.dart';
import 'package:mcn_app/constants/color.dart';
import 'package:mcn_app/constants/constants.dart';
import 'package:mcn_app/repository/login_repository.dart';
import 'package:mcn_app/routers/routers.dart';
import 'package:mcn_app/ui/splash/splash_screen.dart';
import 'package:mcn_app/utils/simple_bloc_delegate.dart';
import 'package:mcn_app/utils/ui_helper.dart';
import 'package:mcn_app/widgets/error/error_screen.dart';

import 'di/module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await Hive.initFlutter();
  await Hive.openBox(HiveConstant.box);

  Bloc.observer = SimpleBlocObserver();

  //repository
  var loginRepository = LoginRepository();
  return runZonedGuarded(() async {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationCubit(loginRepository))
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue, canvasColor: Colors.white),
        onGenerateRoute: (settings) => Routers.onGenerateRoute(settings),
        initialRoute: Routers.START_PAGE,
      ),
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
  late AuthenticationCubit authenticationCubit;

  @override
  void initState() {
    super.initState();
    UiHelper.changeStatusBarColor(statusBarColor: CustomColor.PRIMARY_COLOR);
    authenticationCubit = BlocProvider.of<AuthenticationCubit>(context);
    authenticationCubit.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(constraints);
        return Scaffold(
          body: BlocBuilder(
            bloc: authenticationCubit,
            builder: (ctx, state) {
              if (state is AuthenticationLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is AuthenticationFailedState) {
                return Container(
                  child: Center(
                    child: Text("Login screen"),
                  ),
                );
              }

              if (state is AuthenticationSuccessState) {
                return Container(
                  child: Center(
                    child: Text("Home screen"),
                  ),
                );
              }

              return Container();
            },
          ),
        );
      },
    );
  }
}
