import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';

class SignUpOrgPage extends StatefulWidget {
  const SignUpOrgPage({super.key});

  @override
  State<SignUpOrgPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpOrgPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  bool _obscureText = true; // added this to hide password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading,
                  orgNameField, // added this as a new field required
                  emailField,
                  passwordField,
                  proofsOfLegitimacyField,
                  submitButton,
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign Up as Organization",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );
  // added this to get the first name
  Widget get orgNameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Organization Name"),
              hintText: "Enter organization name"),
          onSaved: (value) => setState(() => firstName = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter organization name";
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
            border: const OutlineInputBorder(),
            label: const Text("Password"),
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

  Widget get proofsOfLegitimacyField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Proofs of Legitimacy"),
              hintText: "Upload your organization's proofs of legitimacy"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please upload your organization's proofs of legitimacy";
            }
            return null;
          },
        ),
      );

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // await context
          // .read<UserAuthProvider>()
          // .authService
          // .signUp(firstName!, lastName!, email!, password!); // added firstName and lastName

          // check if the widget hasn't been disposed of after an asynchronous action
          if (mounted) Navigator.pop(context);
        }
      },
      child: const Text("Sign Up"));
}
