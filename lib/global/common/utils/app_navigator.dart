import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppNavigator {
  static goToPage({required BuildContext context, required Widget screen}) {
    return Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeft,
        child: screen,
      ),
    );
  }

  static replaceTo({required BuildContext context, required Widget screen}) {
    return Navigator.pushReplacement(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.bottomToTop,
        child: screen,
      ),
    );
  }

  static replaceToAndRemoveUntil({
    required BuildContext context,
    required Widget screen,
  }) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: screen,
        type: PageTransitionType.bottomToTop,
      ),
      (route) => false,
    );
  }
}
