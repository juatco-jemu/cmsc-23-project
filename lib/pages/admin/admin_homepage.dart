import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_system/mock/mock_organization.dart';
import 'package:donation_system/pages/admin/admin_all_org_and_donos_page.dart';
import 'package:donation_system/pages/admin/admin_approval_page.dart';
import 'package:donation_system/pages/admin/admin_viewall_donors.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../model/model_organization.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Organization> org_list = MockOrganization.fetchAll();
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    AdminViewAll(),
    AdminApprovalPage(),
    AdminViewAllDonors(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: drawer,
        // appBar: const CustomAppBar(
        //   title: "Elbi Donation System Admin",
        // ),
        bottomNavigationBar: botNavBar,
        body: Center(child: _pages.elementAt(_selectedIndex)));
  }

  CurvedNavigationBar get botNavBar => CurvedNavigationBar(
          color: AppColors.yellow03,
          backgroundColor: AppColors.appWhite,
          onTap: _onItemTapped,
          index: _selectedIndex,
          animationDuration: const Duration(milliseconds: 150),
          items: const [
            Icon(Icons.home),
            Icon(Icons.approval),
            Icon(Icons.account_circle),
          ]);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
