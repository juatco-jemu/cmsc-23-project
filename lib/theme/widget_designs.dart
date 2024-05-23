import 'package:flutter/material.dart';
import 'colors.dart';

class CustomWidgetDesigns {
  static BoxDecoration customContainer() {
    return BoxDecoration(
      color: AppColors.appWhite,
      borderRadius: BorderRadius.circular(12),
    );
  }

  static BoxDecoration gradientBackground() {
    return const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
      Color.fromARGB(255, 255, 234, 181),
      AppColors.appWhite,
    ]));
  }

  static InputDecoration customFormField(label, hint) {
    return InputDecoration(
      fillColor: Colors.white, // Change the background color to white
      filled: true, // Enable fillColor
      border: OutlineInputBorder(
        borderSide: BorderSide.none, // Remove the outline
        borderRadius: BorderRadius.circular(10), // Add rounded corners
      ),
      label: Text(label),
      hintText: hint,
      // Add a shadow
    );
  }

  static ButtonStyle customSubmitButton() {
    return const ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.yellow03),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 40.0)),
      minimumSize: WidgetStatePropertyAll(Size(400, 50)),
      shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }

  static BoxDecoration customTileContainer() {
    return BoxDecoration(
      color: AppColors.appWhite,
      borderRadius: BorderRadius.circular(12),
    );
  }
}
