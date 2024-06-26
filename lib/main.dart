import 'package:donation_system/firebase_options.dart';
import 'package:donation_system/pages/main_page.dart';
import 'package:donation_system/providers/provider_address_list.dart';
import 'package:donation_system/providers/provider_auth.dart';
import 'package:donation_system/providers/provider_donation.dart';
import 'package:donation_system/providers/provider_donors.dart';
import 'package:donation_system/providers/provider_drive.dart';
import 'package:donation_system/providers/provider_organizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DonorsProvider()),
    ChangeNotifierProvider(create: (context) => OrganizationsProvider()),
    ChangeNotifierProvider(create: (context) => UserAuthProvider()),
    ChangeNotifierProvider(create: (context) => DonationDriveProvider()),
    ChangeNotifierProvider(create: (context) => AddressListProvider()),
    ChangeNotifierProvider(create: (context) => DonationsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CMSC 23 Project',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
      },
    );
  }
}
