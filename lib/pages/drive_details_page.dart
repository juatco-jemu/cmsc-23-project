import 'package:donation_system/pages/donor/donor_donate_page.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';
import '../model/model_drive.dart';

class DriveDetailsPage extends StatefulWidget {
  final DonationDrive donationDrive;
  final bool isDonor;
  const DriveDetailsPage({super.key, required this.isDonor, required this.donationDrive});

  @override
  State<DriveDetailsPage> createState() => _DriveDetailsPageState();
}

class _DriveDetailsPageState extends State<DriveDetailsPage> {
  final _formKey = GlobalKey<FormState>();
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
                        const Icon(Icons.favorite_border),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.donationDrive.driveStatus),
                        Text("Location: ${widget.donationDrive.driveLocation}"),
                        spacer,
                        Text("Description: ${widget.donationDrive.driveDescription}"),
                        spacer,
                        widget.isDonor ? const DonateForm() : Container(),
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
      bottomSheet: widget.isDonor ? donateButton(context) : viewDonationsButton(context),
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
            // : WidgetStateProperty.all(Colors.grey),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print("Donation Successful");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const DonorDonatePage(),
              //   ),
              // );
            }
          },
          child: const Text(
            "Donate",
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const DonationsList(
            //               isAllDonations: false,
            //             )));
          },
          child: const Text(
            "View Donations",
            style: TextStyle(color: AppColors.appWhite),
          ),
        ),
      ),
    );
  }

  Widget get spacer => const SizedBox(height: 20);
}
