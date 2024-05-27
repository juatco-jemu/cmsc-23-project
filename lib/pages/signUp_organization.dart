import 'package:donation_system/model/model_drive.dart';
import 'package:donation_system/providers/provider_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../theme/widget_designs.dart';

class SignUpOrgPage extends StatefulWidget {
  const SignUpOrgPage({super.key});

  @override
  State<SignUpOrgPage> createState() => _SignUpOrgPageState();
}

class _SignUpOrgPageState extends State<SignUpOrgPage> {
  final _formKey = GlobalKey<FormState>();
  String? orgName;
  String? orgUsername;
  String? email;
  String? password;
  String orgDescription = "";
  List<String> orgAddressList = [];
  String orgContactNumber = "";
  List<DonationDrive> orgDriveList = [];
  String orgProofImgLink = "";
  String orgStatus = "Pending";

  bool _obscureText = true; // added this to hide password

  late Size screen = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: screen.width,
          // height: screen.height,
          decoration: CustomWidgetDesigns.gradientBackground(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                _buildForm(),
              ]),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/signup_org_bg.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(children: [
            Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                    ))),
            Positioned(
                top: 60,
                left: screen.width / 2 - 80,
                child: const Text(
                  "sign up",
                  style: TextStyle(
                      fontFamily: "Baguet Script", fontSize: 50, color: AppColors.darkYellow01),
                )),
            Positioned(
                top: 115,
                left: screen.width / 2 - 20,
                child: const Text(
                  "as",
                  style: TextStyle(
                      fontFamily: "Baguet Script", fontSize: 30, color: AppColors.darkYellow01),
                )),
            Positioned(
                top: 140,
                left: screen.width / 2 - 130,
                child: const Text(
                  "organization",
                  style: TextStyle(
                      fontFamily: "Baguet Script", fontSize: 50, color: AppColors.darkYellow01),
                )),
          ]),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            spacer,
            orgNameField,
            orgUsernameField,
            emailField,
            passwordField,
            // proofsOfLegitimacyField,
            submitButton,
            spacer
          ],
        ),
      ),
    );
  }

  // added this to get the first name
  Widget get orgNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration:
                CustomWidgetDesigns.customFormField("Organization Name", "Enter organization name"),
            onSaved: (value) => setState(() => orgName = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter organization name";
              }
              return null;
            },
          ),
        ),
      );

  Widget get orgUsernameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration:
                CustomWidgetDesigns.customFormField("Organization Username", "Enter organization username"),
            onSaved: (value) => setState(() => orgUsername = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter organization name";
              }
              return null;
            },
          ),
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: CustomWidgetDesigns.customFormField("Email", "Enter your email"),
            onSaved: (value) => setState(() => email = value),
            validator: (value) {
              // added proper email validation
              if (value == null || value.isEmpty) {
                return "Please enter an email";
              } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                  .hasMatch(value)) {
                return "Please enter a valid email format";
              }
              return null;
            },
          ),
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration:
                CustomWidgetDesigns.customFormField("Password", "Enter your password").copyWith(
              suffixIcon: IconButton(
                icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            obscureText: _obscureText,
            onSaved: (value) => setState(() => password = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                // added password validation
                return "Please enter password";
              } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                  .hasMatch(value)) {
                return "Password must have at least 8 characters\nconsisting of at least:\n1 small letter,\n1 capital letter,\n1 digit, and\n1 special character";
              }
              return null;
            },
          ),
        ),
      );

  // Widget get proofsOfLegitimacyField => Padding(
  //       padding: const EdgeInsets.only(bottom: 30),
  //       child: TextFormField(
  //         decoration: CustomWidgetDesigns.customFormField(
  //             "Proofs of Legitimacy", "Upload your organization's proofs of legitimacy"),
  //         onSaved: (value) => setState(() => email = value),
  //         validator: (value) {
  //           if (value == null || value.isEmpty) {
  //             return "Please upload your organization's proofs of legitimacy";
  //           }
  //           return null;
  //         },
  //       ),
  //     );

  Widget get submitButton => ElevatedButton(
      style: CustomWidgetDesigns.customSubmitButton(),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          await context
              .read<UserAuthProvider>()
              .authService
              .signUpOrganization(orgName!, email!, orgUsername!, orgDescription, orgAddressList, orgContactNumber, orgDriveList, orgStatus, password!);

          // check if the widget hasn't been disposed of after an asynchronous action
          if (mounted) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }
      },
      child: const Text("Sign Up"));

  Widget get spacer => const SizedBox(height: 30);
}
