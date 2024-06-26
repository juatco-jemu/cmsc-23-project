import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider_auth.dart';

class PendingOrgPage extends StatelessWidget {
  const PendingOrgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have successfully signed up as an organization!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your application will be reviewed by the admin. We will notify you once the review process is complete. Thank you!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.read<UserAuthProvider>().signOut();
                // Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
