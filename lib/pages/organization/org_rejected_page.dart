import 'package:donation_system/components/appbar.dart';

import 'package:flutter/material.dart';

class OrgRejectedPage extends StatefulWidget {
  const OrgRejectedPage({super.key});

  @override
  State<OrgRejectedPage> createState() => _OrgRejectedPageState();
}

class _OrgRejectedPageState extends State<OrgRejectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Organization Sign Up Rejected'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your organization's sign up request has been rejected.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/");
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
