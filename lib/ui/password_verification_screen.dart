import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordVerificationScreen extends StatefulWidget {
  const PasswordVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<PasswordVerificationScreen> createState() =>
      _PasswordVerificationScreenState();
}

class _PasswordVerificationScreenState
    extends State<PasswordVerificationScreen> {
  @override
  void initState() {
    super.initState();
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
              Text(
                AppLocalizations.of(context)!.verifyTitle,
                style: const TextStyle(
                  fontFamily: "MM",
                  fontSize: 24,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                AppLocalizations.of(context)!.fourDigit,
                style: const TextStyle(
                  fontFamily: "MM",
                  fontSize: 14,
                  color: TextColors.greyText,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.email,
                    style: const TextStyle(
                      fontFamily: "MM",
                      fontSize: 14,
                      color: TextColors.greyText,
                    ),
                  ),
                  Text(
                    " ${widget.email}",
                    style: const TextStyle(
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
                validator: (s) {
                  return s == '2222' ? null : 'Pin is incorrect';
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
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
                  child: Text(
                    AppLocalizations.of(context)!.continuee,
                    style: const TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.didntRecieve,
                    style: const TextStyle(
                      fontFamily: "MM",
                      fontSize: 16,
                      color: TextColors.greyText,
                    ),
                  ),
                  Text(
                    " ${AppLocalizations.of(context)!.resend}",
                    style: const TextStyle(
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
      ),
    );
  }
}
