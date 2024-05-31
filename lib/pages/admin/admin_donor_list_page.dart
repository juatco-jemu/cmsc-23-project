import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_donor.dart';
import 'package:donation_system/providers/provider_auth.dart';
import 'package:donation_system/providers/provider_donors.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
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
      body: SingleChildScrollView(
        child: Container(
            height: screenHeight,
            width: screenWidth,
            // decoration: CustomWidgetDesigns.gradientBackground(),
            color: AppColors.backgroundYellow,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                spacer(50),
                _buildHeader(),
                showDonors(context),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.yellow03,
        onPressed: () {
          context.read<UserAuthProvider>().signOut();
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}

Widget spacer(double height) {
  return SizedBox(height: height);
}

Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Admin: Donors',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset('assets/images/cloud01.png', height: 80),
        )
      ],
    );
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

      return Expanded(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemCount: donors.length,
            itemBuilder: (context, index) {
              Donor donor = donors[index];
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: CustomWidgetDesigns.customTileContainer(),
                  child: ListTile(
                    title: Text(
                      '${donor.firstName ?? ''} ${donor.lastName ?? ''}'.trim().isEmpty
                          ? 'No Name'
                          : '${donor.firstName ?? ''} ${donor.lastName ?? ''}'.trim(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Username: ${donor.username}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => OrganizationDetailPage(organization: organization),
                      //   ),
                      // );
                    },
                  ));
            },
          ),
        ),
      );
    },
  );
}
