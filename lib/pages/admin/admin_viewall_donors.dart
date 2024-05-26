import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminViewAllDonors extends StatefulWidget {
  const AdminViewAllDonors({super.key});

  @override
  State<AdminViewAllDonors> createState() => _AdminViewAllDonorsState();
}

class _AdminViewAllDonorsState extends State<AdminViewAllDonors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Donors"),
      ),
      body: Container(),
    );
    // Stream<QuerySnapshot> donorStream = context.watch<AdminProvider>().donors;
    //   return StreamBuilder(
    //     stream: donorStream,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text("Error encountered! ${snapshot.error}"),
    //         );
    //       } else if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else if (snapshot.data!.docs.isEmpty) {
    //         // changed this to check if the current user's todo list is empty
    //         return const Center(
    //           child: Text("No Donors Found"),
    //         );
    //       }

    //       return ListView(
    //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //           return ListTile(
    //             title: Text(data['name']),
    //             subtitle: Text(data['email']),
    //           );
    //         }).toList(),
    //       );
    //     },
    //   );
    // }
  }
}
