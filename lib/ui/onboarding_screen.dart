import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/authentication/authentication_bloc.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/login_screen.dart';
import 'package:cinemax/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/splash_logo.svg",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "CINEMAX",
              style: TextStyle(
                fontFamily: "MSB",
                color: TextColors.whiteText,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 40,
              width: 200,
              child: Text(
                AppLocalizations.of(context)!.enterNumber,
                style: const TextStyle(
                  fontFamily: "MSB",
                  fontSize: 14,
                  color: TextColors.greyText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 56,
                width: userScreenSize.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AuthBloc(locator.get()),
                          child: const RegisterScreen(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: const TextStyle(
                      fontFamily: "MM",
                      fontSize: 16,
                      color: TextColors.whiteText,
                    ),
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
                  AppLocalizations.of(context)!.haveAccount,
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: (userScreenSize.width < 325) ? 12 : 16,
                    color: TextColors.greyText,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AuthBloc(locator.get()),
                          child: const LoginScreen(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(
                      color: PrimaryColors.blueAccentColor,
                      fontFamily: "MM",
                      fontSize: (userScreenSize.width < 325) ? 12 : 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Visibility(
                    visible: (userScreenSize.width < 325) ? false : true,
                    child: const Divider(
                      color: PrimaryColors.softColor,
                      thickness: 1.4,
                      indent: 80,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    AppLocalizations.of(context)!.orSignupWith,
                    style: const TextStyle(
                      fontFamily: "MM",
                      fontSize: 14,
                      color: TextColors.greyText,
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: (userScreenSize.width < 325) ? false : true,
                    child: const Divider(
                      color: PrimaryColors.softColor,
                      thickness: 1.4,
                      endIndent: 80,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/Google.svg",
                ),
                const SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "assets/images/Apple.svg",
                ),
                const SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(
                  "assets/images/Facebook.svg",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
