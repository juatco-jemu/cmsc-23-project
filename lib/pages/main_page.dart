import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_system/pages/temp_page.dart';
import 'package:donation_system/providers/provider_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<UserAuthProvider>().userStream;
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error encountered! ${snapshot.error}"),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData) {
          return const SignInPage();
        } else {
          User? user = context.read<UserAuthProvider>().user;
          String? email = user!.email;

          return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('donors')
                .where('email', isEqualTo: email)
                .limit(1)
                .get(),
            builder: (context, donorSnapshot) {
              if (donorSnapshot.hasData) {
                QuerySnapshot snapshotData =
                    donorSnapshot.data as QuerySnapshot;
                if (snapshotData.docs.isNotEmpty) {
                  // Email exists in donors collection, navigate to DonorPage
                  return const DonorPage();
                } else {
                  // Email does not exist in donors collection, check organizations collection
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('organizations')
                        .where('orgEmail', isEqualTo: email)
                        .limit(1)
                        .get(),
                    builder: (context, orgSnapshot) {
                      if (orgSnapshot.hasData) {
                        QuerySnapshot snapshotData =
                            orgSnapshot.data as QuerySnapshot;
                        if (snapshotData.docs.isNotEmpty) {
                          // Email exists in organizations collection, navigate to OrganizationPage
                          return const OrganizationPage();
                        } else {
                          // Email does not exist in organizations collection, navigate to WelcomePage
                          return const AdminPage();
                        }
                      } else if (orgSnapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text(
                                "Error encountered! ${orgSnapshot.error}"),
                          ),
                        );
                      } else {
                        return const Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  );
                }
              } else if (donorSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error encountered! ${donorSnapshot.error}"),
                  ),
                );
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
