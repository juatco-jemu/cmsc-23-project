import 'package:donation_system/model/model_donation_drive.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';

import 'donate_page.dart';

class DriveDetailsPage extends StatefulWidget {
  final DonationDrive donationDrive;
  const DriveDetailsPage({super.key, required this.donationDrive});

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
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.aliceBlue,
          width: screen.width,
          height: screen.height,
          child: Column(
            children: [
              Container(
                height: 250,
                width: screen.width,
                color: AppColors.tiffanyBlue,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.donationDrive.title,
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        const Icon(Icons.favorite_border),
                      ],
                    ),
                    spacer,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status: ${widget.donationDrive.status}"),
                        Text("Location: ${widget.donationDrive.location}"),
                        Text("Description: ${widget.donationDrive.description}"),
                      ],
                    ),
                    spacer,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: donateButton(context),
    );
  }

  Widget donateButton(context) {
    return Container(
      color: AppColors.tiffanyBlue,
      width: screen.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const DonatePage()));
            showModalBottomSheet(
              context: context,
              builder: (context) => FractionallySizedBox(
                  heightFactor: 0.75,
                  child: Column(
                    children: [
                      hBar,
                      const Flexible(child: DonatePage()),
                    ],
                  )),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              isScrollControlled: true,
            );
          },
          child: const Text("Donate"),
        ),
      ),
    );
  }

  Widget get hBar => Container(
        width: 100,
        height: 4,
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.circular(12),
        ),
      );

  Widget get spacer => const SizedBox(height: 20);
}
