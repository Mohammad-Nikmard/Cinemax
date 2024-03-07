import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    nameController.dispose();
    super.dispose();
  }

  bool isTermsChecked = false;
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
                    "Sign Up",
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
                "let's get started",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 24,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                width: 183,
                child: Text(
                  "the latest movies ans series are here",
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
                text: "Full Name",
                controller: nameController,
              ),
              const SizedBox(
                height: 30,
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
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      side: const BorderSide(
                        width: 1.3,
                        color: TextColors.greyText,
                      ),
                      checkColor: Colors.transparent,
                      activeColor: TextColors.greyText,
                      value: isTermsChecked,
                      onChanged: (value) {
                        setState(() {
                          isTermsChecked = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "I agree to the ",
                            style: TextStyle(
                              fontFamily: "MM",
                              fontSize: 12,
                              color: TextColors.greyText,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Terms and Services",
                              style: TextStyle(
                                fontFamily: "MM",
                                fontSize: 12,
                                color: PrimaryColors.blueAccentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "and ",
                            style: TextStyle(
                              fontFamily: "MM",
                              fontSize: 12,
                              color: TextColors.greyText,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Privacy Policy",
                              style: TextStyle(
                                fontFamily: "MM",
                                fontSize: 12,
                                color: PrimaryColors.blueAccentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                    "Sign Up",
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
