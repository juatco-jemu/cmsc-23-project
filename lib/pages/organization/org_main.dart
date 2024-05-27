import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_system/pages/organization/org_donation_drives_page.dart';
import 'package:donation_system/pages/organization/org_homepage.dart';
import 'package:donation_system/pages/organization/org_profile.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

class OrgMain extends StatefulWidget {
  const OrgMain({super.key});

  @override
  State<OrgMain> createState() => _OrgMainState();
}

class _OrgMainState extends State<OrgMain> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const OrgHomepage(),
    const OrgDriveListPage(
      isPage: true,
    ),
    const OrgProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: const CustomAppBar(
        //   title: 'Elbi Donation System',
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
