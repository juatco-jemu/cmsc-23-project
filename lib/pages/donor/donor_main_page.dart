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
  final List<Widget> _pages = [
    const DonorHomePage(),
    const OrganizationsList(isPage: true, isDonor: true),
    const DonorProfilePage(),
  ];
  Donor? donor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DonorsProvider>().getDonorByEmail(widget.email);
    });
    // _fetchDonor();
  }

  // Future<void> _fetchDonor() async {
  //   final getDonor = await context.read<DonorsProvider>().getDonorByEmail(widget.email);
  //   setState(() {
  //     donor = getDonor;
  //     _pages = [
  //       const DonorHomePage(),
  //       const OrganizationsList(isPage: true, isDonor: true),
  //       DonorProfilePage(donor: donor!),
  //     ];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: botNavBar, body: Center(child: _pages.elementAt(_selectedIndex)));
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
