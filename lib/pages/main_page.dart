import 'package:donation_system/pages/admin/admin_main_page.dart';
import 'package:donation_system/pages/signin_page.dart';
import 'package:donation_system/pages/temp_page.dart';
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
    return StreamBuilder<User?>(
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
        // if user is logged in, display the scaffold containing the streambuilder for the todos
          User? user = snapshot.data;
          if (user != null) {
            return FutureBuilder<bool>(
                future: context
                    .read<UserAuthProvider>()
                    .authService
                    .isAdmin(user.email!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else if (snapshot.data == true) {
                    return const AdminMainPage();
                  } else {
                    return FutureBuilder<bool>(
                      future: context
                          .read<UserAuthProvider>()
                          .authService
                          .isAdmin(user.email!),
                      builder: (context, adminSnapshot) {
                        if (adminSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        else if (adminSnapshot.data == true) {
                          return const AdminMainPage();
                        } else {
                          return FutureBuilder<bool>(
                              future: context
                                  .read<UserAuthProvider>()
                                  .authService
                                  .isOrganization(user.email!),
                              builder: (context, orgSnapshot) {
                                if (orgSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Scaffold(
                                    body: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                else if (orgSnapshot.data == true) {
                                  return const OrganizationPage();
                                } else {
                                  return const DonorPage();
                                }
                              });
                        }
                      },
                    );
                  }
                });
          } else {
            return const SignInPage();
          }
      },
    );
  }
}