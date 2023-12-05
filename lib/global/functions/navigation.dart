import 'package:flutter/material.dart';

class Navigation {
  static void navigateToNextScreen(context, widget) =>
      Navigator.of(context).push(SliderRight(page: widget));

  static void navigateAndFinishThisScreen(context, widget) =>
      Navigator.pushAndRemoveUntil(
        context,
        SliderRight(page: widget),
        (Route<dynamic> route) => false,
      );

  static void navigateAndReplace(context, route) =>
      Navigator.pushReplacementNamed(context, route);
}

class SliderRight extends PageRouteBuilder {
  final Widget page;
  SliderRight({required this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionsBuilder: (context, animation, animationTwo, child) {
            var begin = 0.0;
            var end = 1.0;
            var tween = Tween(begin: begin, end: end);
            var curvesAnimated = CurvedAnimation(
              parent: animation,
              curve: Curves.linear,
            );
            return RotationTransition(
              turns: tween.animate(curvesAnimated),
              child: child,
            );
          },
        );
}
