import 'package:donation_system/pages/admin/admin_homepage.dart';
import 'package:donation_system/pages/donor/home.dart';
import 'package:donation_system/pages/donor/profile.dart';
import 'package:donation_system/pages/org_list.dart';
import 'package:donation_system/pages/signin_page.dart';
import 'package:donation_system/pages/signup_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DonorHomepage(),
    const DonationList(),
    const DonorProfilePage()
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

  BottomNavigationBar get botNavBar => BottomNavigationBar(
          backgroundColor: AppColors.tiffanyBlue,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.approval),
              label: 'Donate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'You',
            ),
          ]);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
