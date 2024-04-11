import 'package:cinemax/bloc/splash/splash_bloc.dart';
import 'package:cinemax/bloc/splash/splash_event.dart';
import 'package:cinemax/bloc/splash/splash_state.dart';
import 'package:cinemax/ui/dashobard_screen.dart';
import 'package:cinemax/ui/onboarding_screen.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: BlocConsumer<SplashBloc, SplashState>(
          builder: (context, state) {
            if (state is SplashLoadingState) {
              return Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/splash_logo.svg",
                      ),
                    ),
                    const Positioned(
                      bottom: 20,
                      child: AppLoadingIndicator(),
                    ),
                  ],
                ),
              );
            } else if (state is SplashResponseState) {
              return Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/splash_logo.svg",
                      ),
                    ),
                    const Positioned(
                      bottom: 20,
                      child: AppLoadingIndicator(),
                    ),
                  ],
                ),
              );
            } else if (state is SplashErrorState) {
              return Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/splash_logo.svg",
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.noConnections,
                            style: TextStyle(
                              fontFamily: "MSB",
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          const SizedBox(height: 15),
                          OutlinedButton(
                            onPressed: () {
                              context
                                  .read<SplashBloc>()
                                  .add(CheckConnectionEvent());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.tryAgain,
                              style: TextStyle(
                                fontFamily: "MSB",
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text(AppLocalizations.of(context)!.state),
            );
          },
          listener: (context, state) {
            if (state is SplashResponseState) {
              Future.delayed(
                const Duration(seconds: 3),
                () {
                  if (AuthManager.readToken().isEmpty) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const OnBoardingScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  } else if (AuthManager.readToken().isNotEmpty) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const DashboardScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
