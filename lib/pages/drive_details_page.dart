// import 'package:donation_system/theme/colors.dart';
// import 'package:flutter/material.dart';

// import '../model/model_drive.dart';
// import 'donate_page.dart';

// class DriveDetailsPage extends StatefulWidget {
//   final DonationDrive donationDrive;
//   const DriveDetailsPage({super.key, required this.donationDrive});

//   @override
//   State<DriveDetailsPage> createState() => _DriveDetailsPageState();
// }

// class _DriveDetailsPageState extends State<DriveDetailsPage> {
//   late Size screen = MediaQuery.of(context).size;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(""),
//         backgroundColor: AppColors.yellow03,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           color: AppColors.backgroundYellow,
//           width: screen.width,
//           child: Column(
//             children: [
//               Container(
//                 height: 250,
//                 width: screen.width,
//                 color: AppColors.yellow01,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(widget.donationDrive.driveName,
//                             style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
//                         const Icon(Icons.favorite_border),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(widget.donationDrive.driveStatus),
//                         Text("Location: ${widget.donationDrive.driveLocation}"),
//                         spacer,
//                         Text("Description: ${widget.donationDrive.driveDescription}"),
//                         spacer,
//                         const DonateForm(),
//                       ],
//                     ),
//                     spacer,
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomSheet: donateButton(context),
//     );
//   }

//   Widget donateButton(context) {
//     return Container(
//       color: AppColors.backgroundYellow,
//       width: screen.width,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor: WidgetStateProperty.all(AppColors.yellow02),
//             shape: WidgetStateProperty.all(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//           onPressed: () {
//             // Navigator.push(context, MaterialPageRoute(builder: (context) => const DonatePage()));
//             showModalBottomSheet(
//               context: context,
//               builder: (context) => FractionallySizedBox(
//                   heightFactor: 0.75,
//                   child: Column(
//                     children: [
//                       hBar,
//                       const Flexible(child: DonateForm()),
//                     ],
//                   )),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               isScrollControlled: true,
//             );
//           },
//           child: const Text(
//             "Donate",
//             style: TextStyle(color: AppColors.appWhite),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget get hBar => Container(
//         width: 100,
//         height: 4,
//         margin: const EdgeInsets.only(top: 12, bottom: 12),
//         decoration: BoxDecoration(
//           color: Colors.grey[500],
//           borderRadius: BorderRadius.circular(12),
//         ),
//       );

//   Widget get spacer => const SizedBox(height: 20);
// }
