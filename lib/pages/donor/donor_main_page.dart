import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_system/pages/donor/donor_home_page.dart';
import 'package:donation_system/pages/temp_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

class DonorMainPage extends StatefulWidget {
  const DonorMainPage({super.key});

  @override
  State<DonorMainPage> createState() => _DonorMainPageState();
}

class _DonorMainPageState extends State<DonorMainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DonorHomePage(),
    const OrganizationPage(),
    const AdminPage(),
    // const OrganizationsList(
    //   isDonor: true,
    //   isPage: true,
    // ),
    // const DonorProfilePage(),
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
          backgroundColor: AppColors.backgroundYellow,
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