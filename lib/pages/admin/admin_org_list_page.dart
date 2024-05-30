// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:donation_system/model/model_organization.dart';
// import 'package:donation_system/pages/admin/admin_org_detail_page.dart';
// import 'package:donation_system/providers/provider_organizations.dart';
// import 'package:donation_system/theme/colors.dart';
// import 'package:donation_system/theme/widget_designs.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AdminOrganizationList extends StatefulWidget {
//   const AdminOrganizationList({super.key});

//   @override
//   State<AdminOrganizationList> createState() => _AdminOrganizationListState();
// }

// class _AdminOrganizationListState extends State<AdminOrganizationList> {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Admin - Organization List"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//               // Navigator.of(context).popUntil((route) => route.isFirst);
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         height: screenHeight,
//         width: screenWidth,
//         // decoration: CustomWidgetDesigns.gradientBackground(),
//         color: AppColors.backgroundYellow,
//         child: showOrganizations(context)
//       ),
//     );
//   }
// }

// Widget showOrganizations(BuildContext context) {
//   Stream<QuerySnapshot> organizationStream = context.watch<OrganizationsProvider>().organization;
//   return StreamBuilder<QuerySnapshot>(
//     stream: organizationStream,
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return Center(
//           child: Text("Error encountered! ${snapshot.error}"),
//         );
//       } else if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (!snapshot.hasData) {
//         return const Center(
//           child: Text("No Organizations Yet!"),
//         );
//       }

//       var organizations = snapshot.data!.docs.map((doc) {
//         return Organization.fromJson(doc.data() as Map<String, dynamic>);
//       }).toList();

//       return ListView.builder(
//         itemCount: organizations.length,
//         itemBuilder: (context, index) {
//         Organization organization = organizations[index];
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           decoration: CustomWidgetDesigns.customTileContainer(),
//           child: ListTile(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Username: ${organization.orgUsername}',
//                   style: const TextStyle(
//                     fontSize: 12, 
//                     color: Colors.grey, 
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   organization.orgName ?? 'No Name',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 4), // Space between text and status container
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: organization.orgStatus == 'Approved' ? Colors.green : Colors.grey,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Text(
//                     organization.orgStatus!.toUpperCase(),
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => OrganizationDetailPage(organization: organization),
//                 ),
//               );
//             },
//           )
//         );
//         },
//       );
//     },
//   );
// }
