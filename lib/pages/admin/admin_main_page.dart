import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_system/pages/admin/admin_donor_list_page.dart';
import 'package:donation_system/pages/admin/admin_org_list_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const AdminOrganizationList(),
    const AdminDonorList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: botNavBar,
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }

  CurvedNavigationBar get botNavBar => CurvedNavigationBar(
    color: AppColors.yellow03,
    backgroundColor: AppColors.backgroundYellow,
    onTap: _onItemTapped,
    index: _selectedIndex,
    animationDuration: const Duration(milliseconds: 150),
    items: const [
      Icon(Icons.home_work_sharp),
      Icon(Icons.groups),
    ],
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
