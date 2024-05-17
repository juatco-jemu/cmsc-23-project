import 'package:donation_system/components/listTile.dart';
import 'package:donation_system/mock/mock_donation.dart';
import 'package:donation_system/model/model_donation.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../mock/mock_donor.dart';
import '../../mock/mock_organization.dart';
import '../../model/model_organization.dart';
import '../../model/model_user.dart';
import '../../theme/widget_designs.dart';

class UserDonationsList extends StatefulWidget {
  const UserDonationsList({super.key});

  @override
  State<UserDonationsList> createState() => _UserDonationsListState();
}

class _UserDonationsListState extends State<UserDonationsList> {
  Donor donor = MockDonor.fetchDonor();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Choose an Organization to Donate to",
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.aliceBlue,
        child: ListView.builder(
          itemCount: donor.donations.length,
          itemBuilder: ((context, index) {
            Donation dono = donor.donations[index];
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: CustomWidgetDesigns.customTileContainer(),
                child: customDonorListTile(title: dono.organization.name, subtitle: dono.status));
          }),
        ),
      ),
    );
  }
}
