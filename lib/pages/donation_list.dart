import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_donation.dart';
import 'package:donation_system/providers/provider_donation.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationsList extends StatefulWidget {
  final bool isDonor;
  final int driveID;
  final String username;
  const DonationsList({super.key, required this.isDonor, required this.driveID, required this.username});

  @override
  State<DonationsList> createState() => _DonationsListState();
}

class _DonationsListState extends State<DonationsList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: AppColors.backgroundYellow,
        child: Column(
          children: [
            spacer,
            _buildHeader(),
            _buildList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        backButton,
        const Text("Donations",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset('assets/images/cloud01.png', height: 80),
        )
      ],
    );
  }

  Widget get backButton => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
            onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
      );

  Widget _buildList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.isDonor ? context.watch<DonationsProvider>().getDonationForDonor(widget.username) : context.watch<DonationsProvider>().getDonationForDrive(widget.driveID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text("No Organizations Yet!"),
          );
        }

        var donations = snapshot.data!.docs.map((doc) {
          return Donation.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        return Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                Donation donation = donations[index];

                return FutureBuilder<String?>(
                  future: context.watch<DonationsProvider>().getDriveNameByDriveID(donation.driveID),
                  builder: (context, driveNameSnapshot) {
                    if (driveNameSnapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: CustomWidgetDesigns.customTileContainer(),
                        child: const ListTile(
                          title: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (!driveNameSnapshot.hasData || driveNameSnapshot.data == null) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: CustomWidgetDesigns.customTileContainer(),
                        child: const ListTile(
                          title: Text('Drive name not found'),
                        ),
                      );
                    }

                    String driveName = driveNameSnapshot.data!;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: CustomWidgetDesigns.customTileContainer(),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ID: ${donation.donationID}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              driveName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                donation.status == 'Confirmed' ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            donation.status.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget get spacer => const SizedBox(height: 40);
}
