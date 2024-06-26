import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/authentication/authentication_bloc.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/ui/login_screen.dart';
import 'package:cinemax/ui/register_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              height: 5,
            ),
            SizedBox(
              height: 40,
              width: 200,
              child: Text(
                AppLocalizations.of(context)!.enterNumber,
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
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
                width: MediaQueryHandler.screenWidth(context),
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
                    style: TextStyle(
                      fontFamily: StringConstants.setMediumPersionFont(),
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary,
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
                    fontFamily: StringConstants.setMediumPersionFont(),
                    fontSize: (MediaQueryHandler.screenWidth(context) < 325)
                        ? 12
                        : 16,
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
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: StringConstants.setMediumPersionFont(),
                      fontSize: (MediaQueryHandler.screenWidth(context) < 325)
                          ? 12
                          : 16,
                    ),
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
