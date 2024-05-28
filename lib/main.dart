import 'package:donation_system/firebase_options.dart';
import 'package:donation_system/pages/donor/donor_main.dart';
import 'package:donation_system/pages/main_page.dart';
import 'package:donation_system/pages/organization/org_main.dart';
import 'package:donation_system/pages/signUp_organization.dart';
import 'package:donation_system/providers/provider_auth.dart';
import 'package:donation_system/providers/provider_donors.dart';
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
    ChangeNotifierProvider(create: ((context) => UserAuthProvider()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CMSC 23 Project',
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUpOrgPage(),
        '/sign-in': (context) => const MainPage(),
      },
    );
  }
}
