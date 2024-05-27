import 'package:donation_system/pages/donations_list.dart';
import 'package:flutter/material.dart';

class OrgHomepage extends StatefulWidget {
  const OrgHomepage({super.key});

  @override
  State<OrgHomepage> createState() => _OrgHomepageState();
}

class _OrgHomepageState extends State<OrgHomepage> {
  @override
  Widget build(BuildContext context) {
    return const DonationsList(
      isAllDonations: true,
    );
  }
}
