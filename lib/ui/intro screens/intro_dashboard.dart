import 'package:cinemax/bloc/splash/splash_bloc.dart';
import 'package:cinemax/bloc/splash/splash_event.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/intro%20screens/first_intro_page.dart';
import 'package:cinemax/ui/intro%20screens/second_intro_page.dart';
import 'package:cinemax/ui/intro%20screens/third_intro_page.dart';
import 'package:cinemax/ui/splash_screen.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroDashboard extends StatefulWidget {
  const IntroDashboard({super.key});

  @override
  State<IntroDashboard> createState() => _IntroDashboardState();
}

class _IntroDashboardState extends State<IntroDashboard> {
  final PageController controller = PageController();

  int pageIndex = 0;

  List<String> titles = [
    "The biggest international and local film streaming",
    "Offers ad-free viewing of high quality",
    "Our service brings together your favorite series",
  ];

  List<String> subs = [
    "checkout what movies-series-animations are upcoming to stay updated.",
    "search your favorite movie-series-animation to see all the details of it ad free!",
    "use comment section to interact with people to find the best suited for you.",
  ];

  List<Widget> pages = const [
    FirstIntroPage(),
    SecondIntroPage(),
    ThirdIntroPage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: 3,
            itemBuilder: (context, index) {
              return pages[index];
            },
            onPageChanged: (value) {
              setState(() {
                pageIndex = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 341,
              decoration: const BoxDecoration(
                color: TextColors.blackText,
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 25, bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        AnimatedDefaultTextStyle(
                          style: const TextStyle(
                            fontFamily: "MSB",
                            fontSize: 18,
                            color: TextColors.whiteText,
                          ),
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            titles[pageIndex],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          subs[pageIndex],
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "MM",
                            color: TextColors.greyText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            spacing: 8.0,
                            radius: 7.0,
                            dotWidth: 10.0,
                            dotHeight: 10.0,
                            strokeWidth: 1.5,
                            dotColor:
                                PrimaryColors.blueAccentColor.withOpacity(0.2),
                            activeDotColor: PrimaryColors.blueAccentColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (controller.page == 2) {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: BlocProvider(
                                  create: (context) =>
                                      SplashBloc()..add(CheckConnectionEvent()),
                                  child: const SplashScreen(),
                                ),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                              AppManager.setFirstTime(false);
                            } else {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.decelerate);
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: PrimaryColors.blueAccentColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/icon_arrow_right.svg',
                                colorFilter: const ColorFilter.mode(
                                  Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
