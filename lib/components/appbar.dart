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
      backgroundColor: AppColors.yellow03,
      foregroundColor: AppColors.darkYellow01,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyDonationsCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyDonationsCustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.backgroundYellow,
      foregroundColor: AppColors.darkYellow01,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Image.asset('assets/images/cloud01.png'), // Replace with your image path
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
