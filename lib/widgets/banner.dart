import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/upcoming_movie_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerContainer extends StatefulWidget {
  const BannerContainer({super.key});

  @override
  State<BannerContainer> createState() => _BannerContainerState();
}

class _BannerContainerState extends State<BannerContainer> {
  final PageController controller =
      PageController(viewportFraction: 0.8, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 155,
          child: PageView.builder(
            itemCount: 3,
            controller: controller,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const UpcomingMovieDetail(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: SizedBox(
                  height: 154,
                  width: 315,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          height: 154,
                          width: 305,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 20,
                          child: SizedBox(
                            width: (screenSize.width < 350) ? 154 : 214,
                            child: Text(
                              "Black Panther: Wakanda Forever",
                              style: TextStyle(
                                fontFamily: "MM",
                                fontSize: (screenSize.width < 350) ? 12 : 16,
                                color: TextColors.whiteText,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Text(
                            "On March 2, 2022",
                            style: TextStyle(
                              fontFamily: "MM",
                              fontSize: (screenSize.width < 350) ? 8 : 12,
                              color: TextColors.whiteText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: ExpandingDotsEffect(
            spacing: 8.0,
            radius: 7.0,
            dotWidth: 10.0,
            dotHeight: 8.0,
            strokeWidth: 1.5,
            dotColor: PrimaryColors.blueAccentColor.withOpacity(0.2),
            activeDotColor: PrimaryColors.blueAccentColor,
          ),
        ),
      ],
    );
  }
}
