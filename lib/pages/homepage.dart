import 'package:donation_system/pages/admin/admin_homepage.dart';
import 'package:donation_system/pages/org_list.dart';
import 'package:donation_system/pages/signin_page.dart';
import 'package:donation_system/pages/signup_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Elbi Donation System'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const DonationList()));
                  },
                  child: const Text("Donation List")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const SignInPage()));
                  },
                  child: const Text("Sign In page")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  child: const Text("Sign Up page")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const AdminPage()));
                  },
                  child: const Text("Admin Page")),
            ],
          ),
        ));
  }
}
