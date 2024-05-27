import 'package:donation_system/pages/signUp_organization.dart';
import 'package:donation_system/providers/provider_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../theme/widget_designs.dart';

class SignUpDonorPage extends StatefulWidget {
  const SignUpDonorPage({super.key});

  @override
  State<SignUpDonorPage> createState() => _SignUpDonorPageState();
}

class _SignUpDonorPageState extends State<SignUpDonorPage> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  List<String> addressList = [];
  String contactNumber = "";
  List<int> donationIDList = [];
  String? password;
  bool _obscureText = true; // added this to hide password

  late Size screen = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: screen.width,
          decoration: CustomWidgetDesigns.gradientBackground(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                _buildForm(),
                spacer,
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
                top: 130,
                left: screen.width / 2 - 90,
                child: const Text(
                  "sign up",
                  style: TextStyle(
                      fontFamily: "Baguet Script", fontSize: 60, color: AppColors.darkYellow01),
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
            firstNameField, // added this as a new field required
            lastNameField, // same as above
            usernameField,
            emailField,
            passwordField,
            submitButton,
            orDivider,
            signUpAsOrgButton,
          ],
        ),
      ),
    );
  }

  // added this to get the first name
  Widget get firstNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: CustomWidgetDesigns.customFormField("First Name", "Enter your first name"),
            onSaved: (value) => setState(() => firstName = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your first name";
              }
              return null;
            },
          ),
        ),
      );
  // added this to get the last name
  Widget get lastNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: CustomWidgetDesigns.customFormField("Last Name", "Enter your last name"),
            onSaved: (value) => setState(() => lastName = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your last name";
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

  Widget get usernameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: CustomWidgetDesigns.customFormField("Username", "Enter your username"),
            onSaved: (value) => setState(() => username = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your username";
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

  Widget get submitButton => ElevatedButton(
      style: CustomWidgetDesigns.customSubmitButton(),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          await context
              .read<UserAuthProvider>()
              .authService
              .signUpDonor(firstName!, lastName!, username!, email!, addressList, contactNumber, donationIDList, password!);

          // check if the widget hasn't been disposed of after an asynchronous action
          if (mounted) Navigator.pop(context);
        }
      },
      child: const Text("Sign Up"));

  Widget get orDivider => const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          "--------------- or ---------------",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      );

  Widget get signUpAsOrgButton => ElevatedButton(
        style: CustomWidgetDesigns.customSubmitButton(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpOrgPage()),
          );
        },
        child: const Text("Sign Up as Organization"),
      );

  Widget get spacer => const SizedBox(height: 30);
}
