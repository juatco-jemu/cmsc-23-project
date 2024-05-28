import 'package:donation_system/components/statusDropdown.dart';
import 'package:donation_system/pages/donate_form_page.dart';
import 'package:donation_system/providers/provider_drive.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model_drive.dart';

class DriveDetailsPage extends StatefulWidget {
  final DonationDrive donationDrive;
  final bool isDonor;
  const DriveDetailsPage({super.key, required this.isDonor, required this.donationDrive});

  @override
  State<DriveDetailsPage> createState() => _DriveDetailsPageState();
}

class _DriveDetailsPageState extends State<DriveDetailsPage> {
  late Size screen = MediaQuery.of(context).size;
  late bool isDriveOpen;

  @override
  void initState() {
    super.initState();
    isDriveOpen = widget.donationDrive.driveStatus == 'Open';
  }

  void toggleDriveStatus(bool value) {
    setState(() {
      isDriveOpen = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: AppColors.yellow03,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.appWhite,
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${widget.donationDrive.driveID}', // Assuming `id` is the field for the donation drive ID
                          style: const TextStyle(
                            fontSize: 14, // Smaller font size for ID
                            color: Colors.grey, // Adjust color as needed
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.donationDrive.driveName,
                              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.favorite_border),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(widget.donationDrive.driveLocation),
                          ],
                        ),
                        const SizedBox(height: 8), // Spacer
                        const Text(
                          "Description:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.donationDrive.driveDescription),
                        const SizedBox(height: 8), // Spacer
                        DropdownStatusSelector(
                          selectedValue: widget.donationDrive.driveStatus,
                          options: const ['Open', 'Closed'],
                          onChanged: (value) {
                            setState(() {
                              widget.donationDrive.driveStatus = value!;
                            });
                            // Update status
                            Provider.of<DonationDriveProvider>(context, listen: false)
                                .updateDonationDriveStatus(widget.donationDrive.driveID, value!);
                          },
                        ),
                        const SizedBox(height: 8), // Spacer
                        widget.isDonor ? const DonateFormPage() : Container(),
                      ],
                    ),
                    const SizedBox(height: 8), // Spacer
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
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () {},
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
      color: AppColors.appWhite,
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
            //             ))
            // );
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