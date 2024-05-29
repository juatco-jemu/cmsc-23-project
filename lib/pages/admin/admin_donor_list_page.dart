import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_donor.dart';
import 'package:donation_system/providers/provider_donors.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDonorList extends StatefulWidget {
  const AdminDonorList({super.key});

  @override
  State<AdminDonorList> createState() => _AdminDonorListState();
}

class _AdminDonorListState extends State<AdminDonorList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - Donor List"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              // Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        // decoration: CustomWidgetDesigns.gradientBackground(),
        color: AppColors.backgroundYellow,
        child: showDonors(context)
      ),
    );
  }
}

Widget showDonors(BuildContext context) {
  Stream<QuerySnapshot> donorStream = context.watch<DonorsProvider>().donor;
  return StreamBuilder<QuerySnapshot>(
    stream: donorStream,
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
          child: Text("No Donors Yet!"),
        );
      }

      var donors = snapshot.data!.docs.map((doc) {
        return Donor.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return ListView.builder(
        itemCount: donors.length,
        itemBuilder: (context, index) {
        Donor donor = donors[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: CustomWidgetDesigns.customTileContainer(),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username: ${donor.username}',
                  style: const TextStyle(
                    fontSize: 12, 
                    color: Colors.grey, 
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${donor.firstName ?? ''} ${donor.lastName ?? ''}'.trim().isEmpty ? 'No Name' : '${donor.firstName ?? ''} ${donor.lastName ?? ''}'.trim(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => OrganizationDetailPage(organization: organization),
              //   ),
              // );
            },
          )
        );
        },
      );
    },
  );
}
