import 'package:donation_system/providers/auth_provider.dart';
import 'package:donation_system/theme/colors.dart';
import 'package:donation_system/theme/widget_designs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signup_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool showSignInErrorMessage = false;
  bool _obscureText = true; // added this to hide password

  late Size screen = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: screen.width,
            height: screen.height,
            decoration: CustomWidgetDesigns.gradientBackground(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  spacer,
                  _buildForm(),
                ])),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            emailField,
            passwordField,
            showSignInErrorMessage ? signInErrorMessage : Container(),
            submitButton,
            signUpButton
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          height: 350,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/login_bg.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(children: [
            Positioned(
                top: 210,
                left: screen.width / 2 - 80,
                child: const Text(
                  "sign in",
                  style: TextStyle(
                      fontFamily: "Baguet Script", fontSize: 60, color: AppColors.darkYellow01),
                )),
          ]),
        ),
      ],
    );
  }

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: CustomWidgetDesigns.customFormField("Email", "Enter your email"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
              return "Please enter your email";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration:
              CustomWidgetDesigns.customFormField("Password", "Enter your password").copyWith(
            suffixIcon: IconButton(
              // added IconButton to show/hide password
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
              return "Please enter your password";
            }
            return null;
          },
        ),
      );

  Widget get signInErrorMessage => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Invalid email or password",
          style: TextStyle(color: Colors.red),
        ),
      );

  Widget get submitButton => ElevatedButton(
      style: CustomWidgetDesigns.customSubmitButton(),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          String? message =
              await context.read<UserAuthProvider>().authService.signIn(email!, password!);
          print("Current user: ${context.read<UserAuthProvider>().authService.getUser()}");
          print("message: $message");
          print(showSignInErrorMessage);

          setState(() {
            if (message != null && message.isNotEmpty) {
              showSignInErrorMessage = true;
            } else {
              showSignInErrorMessage = false;
            }
          });
        }
      },
      child: const Text("Sign In"));

  Widget get signUpButton => Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No account yet?"),
            TextButton(
                style: TextButton.styleFrom(foregroundColor: AppColors.yellow03),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                },
                child: const Text("Sign Up"))
          ],
        ),
      );

  Widget get spacer => const SizedBox(height: 60);
}
