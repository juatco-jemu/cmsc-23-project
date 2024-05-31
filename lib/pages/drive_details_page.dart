import 'package:donation_system/model/model_donor.dart';
import 'package:donation_system/pages/donor/donor_donate.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:flutter/material.dart';
import '../model/model_drive.dart';

class DriveDetailsPage extends StatefulWidget {
  final Donor? donor;
  final DonationDrive donationDrive;
  final bool isDonor;
  const DriveDetailsPage(
      {super.key, required this.isDonor, required this.donationDrive, required this.donor});

  @override
  State<DriveDetailsPage> createState() => _DriveDetailsPageState();
}

class _DriveDetailsPageState extends State<DriveDetailsPage> {
  late Size screen = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: AppColors.yellow03,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.backgroundYellow,
          width: screen.width,
          height: screen.height,
          child: Column(
            children: [
              Container(
                height: 250,
                width: screen.width,
                color: AppColors.yellow01,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.donationDrive.driveName,
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        location(widget.donationDrive.driveLocation),
                        spacer(10),
                        driveStatus(widget.donationDrive.driveStatus),
                        spacer(20),
                        description(widget.donationDrive.driveDescription),
                        spacer(20),
                      ],
                    ),
                    spacer(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: widget.isDonor ? donateButton(context) : viewDonationsButton(context),
    );
  }

  Widget description(description) {
    return Container(
      width: screen.width,
      padding: const EdgeInsets.all(20),
      decoration: CustomWidgetDesigns.customContainer(),
      child: Text("         $description",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }

  Widget location(location) {
    return Row(children: [
      const Icon(Icons.location_on, size: 16, color: Colors.grey),
      Text(location),
    ]);
  }

  Widget driveStatus(status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status == 'Open' ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget donateButton(context) {
    return Container(
      color: AppColors.backgroundYellow,
      width: screen.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.yellow02),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonatePage(donor: widget.donor, drive: widget.donationDrive),
              ),
            );
          },
          child: const Text(
            "Donate Here",
            style: TextStyle(color: AppColors.appWhite),
          ),
        ),
      ),
    );
  }

  Widget viewDonationsButton(context) {
    return Container(
      color: AppColors.backgroundYellow,
      width: screen.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.yellow02),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {
            // Implement view donations navigation here
          },
          child: const Text(
            "View Donations",
            style: TextStyle(color: AppColors.appWhite),
          ),
        ),
      ),
    );
  }

  Widget spacer(double height) {
    return SizedBox(height: height);
  }
}
