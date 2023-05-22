import 'package:flutter/cupertino.dart';

class SlideBottomRoute extends PageRouteBuilder {
  final Widget widget;

  SlideBottomRoute({required this.widget}) : super(
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
              begin: const Offset(0.0, 1.0), end: Offset.zero
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );
      }
  );
}