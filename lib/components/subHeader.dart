import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  final String title;
  final String route;
  const SubHeader({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
              child: const Text("View All")),
        ],
      ),
    );
  }
}
