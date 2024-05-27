import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_system/pages/donor/donor_homepage.dart';
import 'package:donation_system/pages/donor/donor_profile.dart';
import 'package:donation_system/pages/org_list.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

class DonorMain extends StatefulWidget {
  const DonorMain({super.key});

  @override
  State<DonorMain> createState() => _DonorMainState();
}

class _DonorMainState extends State<DonorMain> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DonorHomepage(),
    const OrganizationsList(
      isPage: true,
    ),
    const DonorProfilePage(),
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
