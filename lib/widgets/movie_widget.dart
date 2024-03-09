import 'dart:ui';

import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/movie_detail_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key, required this.showRate});
  final bool showRate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: const MovieDetailScreen(),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: SizedBox(
        height: (MediaQueryHandler.screenWidth(context) < 350) ? 185 : 231,
        child: Column(
          children: [
            Container(
              width: (MediaQueryHandler.screenWidth(context) < 350) ? 115 : 145,
              height:
                  (MediaQueryHandler.screenWidth(context) < 350) ? 142 : 178,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Visibility(
                      visible: showRate,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Transform.scale(
                            scale:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 0.8
                                    : 1,
                            child: Container(
                              height: 24,
                              width: 55,
                              decoration: BoxDecoration(
                                color: const Color(0xff252836).withOpacity(0.3),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/icon_star.png',
                                    color: SecondaryColors.orangeColor,
                                    height: 16,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "4.5",
                                    style: TextStyle(
                                      fontFamily: "MM",
                                      fontSize: 12,
                                      color: SecondaryColors.orangeColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: (MediaQueryHandler.screenWidth(context) < 350) ? 115 : 145,
              height: (MediaQueryHandler.screenWidth(context) < 350) ? 48 : 53,
              decoration: const BoxDecoration(
                color: PrimaryColors.softColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Life of PI whatever bro",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 14,
                        color: TextColors.whiteText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Action",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 8
                            : 10,
                        color: TextColors.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
