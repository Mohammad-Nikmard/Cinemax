import 'package:cinemax/bloc/authentication/authentication_bloc.dart';
import 'package:cinemax/bloc/authentication/authentication_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/password_verification_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

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
                AppLocalizations.of(context)!.resetPassword,
                style: const TextStyle(
                  fontFamily: "MM",
                  fontSize: 28,
                  color: TextColors.whiteText,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                AppLocalizations.of(context)!.recovePw,
                style: const TextStyle(
                  fontFamily: "MM",
                  fontSize: 14,
                  color: TextColors.greyText,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MyTextField(
                text: AppLocalizations.of(context)!.emailAd,
                controller: emailController,
              ),
              const SizedBox(
                height: 50,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitState) {
                    return SizedBox(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.next,
                          style: const TextStyle(
                            fontFamily: "MM",
                            fontSize: 16,
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                    );
                  } else if (state is AuthLoadingState) {
                    return const AppLoadingIndicator();
                  } else if (state is AuthRegisterResponseState) {
                    return SizedBox(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.next,
                          style: const TextStyle(
                            fontFamily: "MM",
                            fontSize: 16,
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(AppLocalizations.of(context)!.state),
                  );
                },
                listener: (context, state) {
                  if (state is AuthRegisterResponseState) {
                    state.registerRespnse.fold(
                      (exceptionMessage) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: _SnackFailMessage(
                                error:
                                    "The username does NOT exist. Please try again."),
                            backgroundColor: Colors.transparent,
                            closeIconColor: Colors.transparent,
                            elevation: 0,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      (response) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordVerificationScreen(
                              email: emailController.text.trim(),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SnackFailMessage extends StatelessWidget {
  const _SnackFailMessage({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        width: MediaQueryHandler.screenWidth(context),
        height: 60,
        decoration: const BoxDecoration(
          color: SecondaryColors.redColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Center(
            child: Text(
              error,
              style: const TextStyle(
                color: TextColors.whiteText,
                fontSize: 12,
                fontFamily: "MSB",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
