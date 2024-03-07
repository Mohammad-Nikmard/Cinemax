import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PasswordVerificationScreen extends StatelessWidget {
  const PasswordVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              "Verifying your Account",
              style: TextStyle(
                fontFamily: "MM",
                fontSize: 24,
                color: TextColors.whiteText,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "We have just sent you 4 digit code via your",
              style: TextStyle(
                fontFamily: "MM",
                fontSize: 14,
                color: TextColors.greyText,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "email ",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 14,
                    color: TextColors.greyText,
                  ),
                ),
                Text(
                  "example@gmail.com",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 14,
                    color: TextColors.whiteText,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Pinput(
              onCompleted: (pin) => print(pin),
              defaultPinTheme: const PinTheme(
                textStyle: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 26,
                  color: TextColors.whiteText,
                ),
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: PrimaryColors.softColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              submittedPinTheme: PinTheme(
                textStyle: const TextStyle(
                  fontFamily: "MSB",
                  fontSize: 26,
                  color: TextColors.whiteText,
                ),
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: PrimaryColors.blueAccentColor, width: 1),
                  color: PrimaryColors.softColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              focusedPinTheme: const PinTheme(
                textStyle: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 26,
                  color: TextColors.whiteText,
                ),
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: PrimaryColors.softColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 16,
                    color: TextColors.whiteText,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't recieve code? ",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 16,
                    color: TextColors.greyText,
                  ),
                ),
                Text(
                  "Resend",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 16,
                    color: PrimaryColors.blueAccentColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
