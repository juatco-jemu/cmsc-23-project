import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.tiffanyBlue,
      foregroundColor: AppColors.carribeanCurrent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
