import 'package:flutter/material.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  CustomPageRouteBuilder({
    required RouteSettings settings,
    required this.pageBuilder,
    this.transitionsBuilder = _defaultTransitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    required this.barrierColor,
    required this.barrierLabel,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(opaque != null),
        super(
            pageBuilder: pageBuilder,
            barrierColor: barrierColor,
            barrierDismissible: barrierDismissible,
            barrierLabel: barrierLabel,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
            opaque: opaque,
            reverseTransitionDuration: reverseTransitionDuration,
            settings: settings,
            transitionDuration: transitionDuration,
            transitionsBuilder: transitionsBuilder);

  @override
  final RoutePageBuilder pageBuilder;

  @override
  final RouteTransitionsBuilder transitionsBuilder;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;
}

Widget _defaultTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return SlideTransition(
    position:
        Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
    child: child,
  );
}
