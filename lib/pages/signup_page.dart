import 'package:donation_system/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import 'signup_org_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  bool _obscureText = true; // added this to hide password

  late Size screen = MediaQuery.of(context).size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            width: screen.width,
            height: screen.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight, // size of screen - appbar height - status bar height
            decoration: const BoxDecoration(
              color: AppColors.tiffanyBlue,
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              _buildBot(),
            ]),
          ),
        ));
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            spacer,
            heading,
            firstNameField, // added this as a new field required
            lastNameField, // same as above
            emailField,
            passwordField,
            submitButton,
            orDivider,
            signUpAsOrgButton,
            spacer,
          ],
        ),
      ),
    );
  }

  Widget _buildBot() {
    return SizedBox(
      width: screen.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: _buildForm(),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );
  // added this to get the first name
  Widget get firstNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("First Name"),
              hintText: "Enter your first name"),
          onSaved: (value) => setState(() => firstName = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your first name";
            }
            return null;
          },
        ),
      );
  // added this to get the last name
  Widget get lastNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Last Name"),
              hintText: "Enter your last name"),
          onSaved: (value) => setState(() => lastName = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your last name";
            }
            return null;
          },
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(), label: Text("Email"), hintText: "Enter a valid email"),
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
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Password"),
            hintText: "At least 8 characters",
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
      );

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          await context
          .read<UserAuthProvider>()
          .authService
          .signUp(firstName!, lastName!, email!, password!); // added firstName and lastName

          // check if the widget hasn't been disposed of after an asynchronous action
          if (mounted) Navigator.pop(context);
        }
      },
      child: const Text("Sign Up"));

  Widget get orDivider => const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "---------- or ----------",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
      );

  Widget get signUpAsOrgButton => ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpOrgPage()),
          );
        },
        child: const Text("Sign Up as Organization"),
      );

  Widget get spacer => const SizedBox(height: 20);
}
