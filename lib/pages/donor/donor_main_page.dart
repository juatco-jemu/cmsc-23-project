import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_system/model/model_donor.dart';
import 'package:donation_system/pages/donor/donor_home_page.dart';
import 'package:donation_system/pages/donor/donor_profile_page.dart';
import 'package:donation_system/pages/org_list_page.dart';
import 'package:donation_system/providers/provider_donors.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorMainPage extends StatefulWidget {
  final String email;

  const DonorMainPage({super.key, required this.email});

  @override
  State<DonorMainPage> createState() => _DonorMainPageState();
}

class _DonorMainPageState extends State<DonorMainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<DonorsProvider>().getDonorByEmail(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    Donor? donor = context.watch<DonorsProvider>().donorData;
    final List<Widget> pages = [
      DonorHomePage(donor: donor),
      const OrganizationsList(isPage: true, isDonor: true),
      DonorProfilePage(donor: donor),
    ];
    return Scaffold(
        bottomNavigationBar: botNavBar, body: Center(child: pages.elementAt(_selectedIndex)));
  }

  CurvedNavigationBar get botNavBar => CurvedNavigationBar(
          color: AppColors.yellow03,
          backgroundColor: AppColors.backgroundYellow,
          onTap: _onItemTapped,
          index: _selectedIndex,
          animationDuration: const Duration(milliseconds: 150),
          items: const [
            Icon(Icons.home),
            Icon(Icons.home_work_sharp),
            Icon(Icons.account_circle),
          ]);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
