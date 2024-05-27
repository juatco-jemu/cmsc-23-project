import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_drive.dart';
import 'package:donation_system/pages/organization/org_add_drive_page.dart';
import 'package:donation_system/providers/provider_drive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationHomePage extends StatefulWidget {
  final String orgUsername;

  const OrganizationHomePage({Key? key, required this.orgUsername}) : super(key: key);

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Org - Donation Drives"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: showDonationDrives(context, widget.orgUsername),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDonationDrivePage(orgUsername: widget.orgUsername),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget showDonationDrives(BuildContext context, String orgUsername) {
  Stream<QuerySnapshot> donationDriveStream = context.watch<DonationDriveProvider>().getDonationDrivesForOrganization(orgUsername);
  return StreamBuilder<QuerySnapshot>(
    stream: donationDriveStream,
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("Error encountered! ${snapshot.error}"),
        );
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(
          child: Text("No Donation Drives Yet!"),
        );
      }

      return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot document = snapshot.data!.docs[index];
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          DonationDrive donationDrive = DonationDrive.fromJson(data);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  donationDrive.driveName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Status: ${donationDrive.driveStatus}'),
                onTap: () {
                  // Handle onTap action if needed
                },
              ),
            ),
          );
        },
      );
    },
  );
}
