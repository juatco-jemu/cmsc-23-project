import 'package:flutter/material.dart';

class CustomNavbarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const CustomNavbarItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
