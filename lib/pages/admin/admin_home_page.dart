import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/model/model_organization.dart';
import 'package:donation_system/pages/admin/admin_org_detail_page.dart';
import 'package:donation_system/providers/provider_organizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - Organization List"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: showOrganizations(context),
    );
  }
}

Widget showOrganizations(BuildContext context) {
  Stream<QuerySnapshot> organizationStream = context.watch<OrganizationsProvider>().organization;
  return StreamBuilder<QuerySnapshot>(
    stream: organizationStream,
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

      var organizations = snapshot.data!.docs.map((doc) {
        return Organization.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return ListView.builder(
        itemCount: organizations.length,
        itemBuilder: (context, index) {
          Organization organization = organizations[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  organization.orgName ?? 'No Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Status: ${organization.orgStatus}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OrganizationDetailPage(organization: organization),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    },
  );
}
