import 'package:flutter/material.dart';

class ScaleNavigation extends PageRouteBuilder {
  final Widget child;
  final Alignment alignment;
  final int animationDuration;
  final double borderRadius;
  final Curve curve;
  final Curve reverseCurve;
  ScaleNavigation({
    this.child,
    this.alignment,
    this.animationDuration = 200,
    this.borderRadius = 0,
    this.curve = Curves.linear,
    this.reverseCurve = Curves.linear,
  }) : super(
          transitionDuration: Duration(milliseconds: animationDuration),
          reverseTransitionDuration: Duration(milliseconds: animationDuration),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = Tween<double>(
              begin: 0,
              end: 1,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: curve,
                reverseCurve: reverseCurve,
              ),
            );
            return ScaleTransition(
              alignment: alignment,
              scale: animation,
              child: ClipRRect(
                child: child,
                borderRadius: BorderRadius.circular(
                  borderRadius - borderRadius * animation.value,
                ),
              ),
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return child;
          },
        );
}
