import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/intro%20screens/first_intro_page.dart';
import 'package:cinemax/ui/intro%20screens/second_intro_page.dart';
import 'package:cinemax/ui/intro%20screens/third_intro_page.dart';
import 'package:flutter/material.dart';
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
    "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient. ",
    "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient. ",
    "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient. ",
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
                            controller.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.decelerate);
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
                              child: Image.asset(
                                  'assets/images/icon_arrow_right.png'),
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