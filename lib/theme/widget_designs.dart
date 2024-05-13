import 'package:flutter/material.dart';
import 'colors.dart';

class CustomWidgetDesigns {
  static BoxDecoration customContainer() {
    return BoxDecoration(
      color: AppColors.aliceBlue,
      borderRadius: BorderRadius.circular(12),
    );
  }

  static BoxDecoration gradientBackground() {
    return const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
      AppColors.paleDogwood,
      AppColors.paleDogwood,
      AppColors.tiffanyBlue,
    ]));
  }

  static ButtonStyle customButton() {
    return const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(AppColors.darkPink),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 40.0)),
    );
  }

  static BoxDecoration customTileContainer() {
    return BoxDecoration(
      color: AppColors.appWhite,
      borderRadius: BorderRadius.circular(12),
    );
  }
}
