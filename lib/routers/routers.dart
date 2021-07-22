import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

class Routers {
  static const START_PAGE = "start-page";

  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case START_PAGE:
        return MaterialPageRoute(
            settings: RouteSettings(name: START_PAGE),
            builder: (_) => StartPage());

      default:
        return Text("Something went wrong.").fadePage();
    }
  }
}

extension PageRouteTransitions on Widget {
  PageRouteBuilder fadePage({bool opaque = true}) {
    return PageRouteBuilder(
        opaque: opaque,
        transitionDuration: Duration(milliseconds: 250),
        pageBuilder: (ctx, anim, anim2) {
          return this;
        },
        transitionsBuilder: (ctx, anim, anim2, child) {
          return FadeTransition(
            opacity: anim,
            child: child,
          );
        });
  }

  MaterialPageRoute defaultPage() {
    return MaterialPageRoute(builder: (_) => this);
  }
}
