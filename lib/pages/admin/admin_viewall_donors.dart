import 'package:flutter/material.dart';

class AdminViewAllDonors extends StatefulWidget {
  const AdminViewAllDonors({super.key});

  @override
  State<AdminViewAllDonors> createState() => _AdminViewAllDonorsState();
}

class _AdminViewAllDonorsState extends State<AdminViewAllDonors> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Admin View All Donors Page"),
        ],
      ),
    );
  }
}
