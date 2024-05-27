import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonorPage extends StatelessWidget {
  const DonorPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donor Page'),
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
      body: const Center(
        child: Text(
          'Welcome, Donor!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class OrganizationPage extends StatelessWidget {
  const OrganizationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Page'),
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
      body: const Center(
        child: Text(
          'Welcome, Organization!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
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
      body: const Center(
        child: Text(
          'Welcome, Admin!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
