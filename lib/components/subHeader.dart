import 'package:flutter/material.dart';

import '../theme/colors.dart';

class SubHeader extends StatelessWidget {
  final String title;
  final dynamic route;
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
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(AppColors.yellow03),
              ),
              onPressed: () {
                // Navigator.pushNamed(context, route);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => route),
                );
              },
              child: const Text("View All",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        ],
      ),
    );
  }
}
