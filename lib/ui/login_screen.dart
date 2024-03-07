import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackLabel(),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "SBM",
                      fontSize: 16,
                      color: TextColors.whiteText,
                    ),
                  ),
                  SizedBox(
                    width: 32,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Hi There",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 24,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                width: 183,
                child: Text(
                  "Welcome back! Please enter your details.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 12,
                    color: TextColors.wihteGreyText,
                  ),
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              MyTextField(
                text: "Email Address",
                controller: emailController,
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                text: "Password",
                controller: pwController,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: 12,
                        color: PrimaryColors.blueAccentColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: 16,
                      color: TextColors.whiteText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
