import 'package:flutter/material.dart';

class SlideNavigation extends PageRouteBuilder {
  final Widget child;
  final Alignment alignment;
  final int animationDuration;
  final double borderRadius;
  final Curve curve;
  final Curve reverseCurve;
  SlideNavigation({
    this.child,
    this.alignment,
    this.animationDuration = 200,
    this.borderRadius = 0,
    this.curve = Curves.easeOutExpo,
    this.reverseCurve = Curves.easeInExpo,
  }) : super(
          transitionDuration: Duration(milliseconds: animationDuration),
          reverseTransitionDuration: Duration(milliseconds: animationDuration),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );
            var anime = Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset.zero,
            ).animate(
              animation,
            );
            return SlideTransition(
              position: anime,
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
