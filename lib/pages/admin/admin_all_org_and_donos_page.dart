import 'package:donation_system/pages/admin/admin_viewall_donors.dart';
import 'package:flutter/material.dart';

import '../org_list.dart';

class AdminViewAll extends StatefulWidget {
  const AdminViewAll({super.key});

  @override
  State<AdminViewAll> createState() => _AdminViewAllState();
}

class _AdminViewAllState extends State<AdminViewAll> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCardOption("All Organizations", const OrganizationsList(isPage: false)),
          _buildCardOption("All Donors", const AdminViewAllDonors()),
        ],
      ),
    );
  }

  Widget _buildCardOption(title, page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
