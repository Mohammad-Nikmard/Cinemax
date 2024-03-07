import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/password_verification_screen.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const BackLabel(),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            const Text(
              "Reset Password",
              style: TextStyle(
                fontFamily: "MM",
                fontSize: 28,
                color: TextColors.whiteText,
              ),
            ),
            const Text(
              "recover your account password",
              style: TextStyle(
                fontFamily: "MM",
                fontSize: 14,
                color: TextColors.greyText,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextField(
              text: "Email Address",
              controller: emailController,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordVerificationScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Next",
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
    );
  }
}
