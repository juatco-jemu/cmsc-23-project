import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/pages/organization/org_drive_list_page.dart';
import 'package:donation_system/pages/organization/org_home_page.dart';
import 'package:donation_system/pages/organization/org_profile_page.dart';
import 'package:donation_system/providers/provider_organizations.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationMainPage extends StatefulWidget {
  final String orgUsername;

  const OrganizationMainPage({Key? key, required this.orgUsername}) : super(key: key);

  @override
  State<OrganizationMainPage> createState() => _OrganizationMainPageState();
}

class _OrganizationMainPageState extends State<OrganizationMainPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  Organization? organization;

  @override
  void initState() {
    super.initState();
    _fetchOrganization();
  }

  Future<void> _fetchOrganization() async {
    final org =
        await context.read<OrganizationsProvider>().getOrganizationByUsername(widget.orgUsername);
    setState(() {
      organization = org;
      _pages = [
        OrgHomePage(orgUsername: widget.orgUsername),
        OrgDonationDriveListPage(orgUsername: widget.orgUsername, isPage: true),
        OrgProfilePage(organization: organization!),
      ];
    });
  }

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
        animationDuration: const Duration(milliseconds: 200),
        items: const [
          // CustomNavbarItem(icon: Icons.home, label: "Home"),
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
