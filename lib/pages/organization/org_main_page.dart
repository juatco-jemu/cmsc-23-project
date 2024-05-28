import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_system/pages/organization/org_drive_list_page.dart';
import 'package:donation_system/pages/organization/org_home_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

class OrganizationMainPage extends StatefulWidget {
  final String orgUsername;

  const OrganizationMainPage({super.key, required this.orgUsername});

  @override
  State<OrganizationMainPage> createState() => _OrganizationMainPageState();
}

class _OrganizationMainPageState extends State<OrganizationMainPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      OrgHomePage(orgUsername: widget.orgUsername),
      OrgDonationDriveListPage(orgUsername: widget.orgUsername, isPage: true),
      // OrgProfilePage(orgU)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(
      //   title: 'Elbi Donation System',
      // ),
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
      Icon(Icons.home),
      Icon(Icons.approval),
      Icon(Icons.account_circle),
    ],
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
