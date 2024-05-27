import 'package:donation_system/components/listTile.dart';
import 'package:donation_system/model/model_donation.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../mock/mock_donor.dart';
import '../../model/model_donor.dart';
import '../../theme/widget_designs.dart';

class DonorDonationList extends StatefulWidget {
  const DonorDonationList({super.key});

  @override
  State<DonorDonationList> createState() => _DonorDonationListState();
}

class _DonorDonationListState extends State<DonorDonationList> {
  Donor donor = MockDonor.fetchDonor();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todo;
    return Scaffold(
      appBar: const MyDonationsCustomAppBar(
        title: "My Donations",
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.backgroundYellow,
        child: ListView.builder(
          itemCount: donor.donationList!.length,
          itemBuilder: ((context, index) {
            Donation dono = donor.donationList![index];
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: CustomWidgetDesigns.customTileContainer(),
                child: customDonorListTile(title: "Donation ID", subtitle: dono.status!));
          }),
        ),
      ),
    );
  }
}
