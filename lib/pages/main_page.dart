import 'package:donation_system/pages/admin/admin_main_page.dart';
import 'package:donation_system/pages/donor/donor_main_page.dart';
import 'package:donation_system/pages/organization/org_control_page.dart';
import 'package:donation_system/pages/signIn_page.dart';
import 'package:donation_system/providers/provider_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
        } 

        User? user = snapshot.data;
        if (user != null) {
          return FutureBuilder<bool>(
            future: context.read<UserAuthProvider>().authService.isAdmin(user.email!),
            builder: (context, adminSnapshot) {
              if (adminSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (adminSnapshot.data == true) {
                return const AdminMainPage();
              } else {
                return FutureBuilder<bool>(
                  future: context.read<UserAuthProvider>().authService.isOrganization(user.email!),
                  builder: (context, orgSnapshot) {
                    if (orgSnapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (orgSnapshot.data == true) {
                      return OrganizationControlPage(orgEmail: user.email!);
                    } else {
                      return const DonorMainPage();
                    }
                  },
                );
              }
            },
          );
        } else {
          return const SignInPage();
        }
      },
    );
  }
}