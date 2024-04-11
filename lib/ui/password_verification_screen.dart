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
                style: TextStyle(
                  fontFamily: "MM",
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.tertiary,
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
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.tertiary,
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
                defaultPinTheme: PinTheme(
                  textStyle: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  textStyle: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  textStyle: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(
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
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary,
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
