import 'package:donation_system/firebase_options.dart';
import 'package:donation_system/pages/admin/admin_homepage.dart';
import 'package:donation_system/pages/donor/homepage.dart';
import 'package:donation_system/pages/donor/list_of_user_donations_page.dart';
import 'package:donation_system/pages/org_list.dart';
import 'package:donation_system/pages/signin_page.dart';
import 'package:donation_system/pages/signup_org_page.dart';
import 'package:donation_system/pages/signup_page.dart';
import 'package:donation_system/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/provider_admin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
        ChangeNotifierProvider(create: ((context) => AdminProvider()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMSC 23 Project',
      initialRoute: "/",
      routes: {
        "/sign-in": (context) => const SignInPage(),
        "/sign-up-donor": (context) => const SignUpPage(),
        "/sign-up-org": (context) => const SignUpOrgPage(),
        "/": (context) => const AdminHomePage(),
        "/org-list": (context) => const OrganizationsList(isPage: false),
        "/user-donation-list": (context) => const UserDonationsList(),
      },
    );
  }
}
