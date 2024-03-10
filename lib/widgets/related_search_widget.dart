import 'dart:ui';

import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/movie_detail_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RelatedSeachWidget extends StatelessWidget {
  const RelatedSeachWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // PersistentNavBarNavigator.pushNewScreen(
        //   context,
        //   screen: const MovieDetailScreen(),
        //   withNavBar: true, // OPTIONAL VALUE. True by default.
        //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
        // );
      },
      child: SizedBox(
        height: 147,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              height: 147,
              width: 112,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/Bg.png'),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, right: 45),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
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
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 170,
                  child: Text(
                    "Spider-man No Way Home bruh",
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      color: TextColors.whiteText,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_calendar.png',
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      color: TextColors.greyText,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "2021",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 10
                            : 12,
                        color: TextColors.greyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_clock.png',
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      color: TextColors.greyText,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "148 Minutes",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 10
                            : 12,
                        color: TextColors.greyText,
                      ),
                    ),
                    SizedBox(
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 3
                          : 15,
                    ),
                    Container(
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 15
                          : 20,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 21
                          : 43,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: PrimaryColors.blueAccentColor,
                          width: 1.4,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "PG-13",
                          style: TextStyle(
                            color: PrimaryColors.blueAccentColor,
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 6
                                    : 12,
                            fontFamily: "MM",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 16,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_film.png',
                        height: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        width: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "Action",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 10
                                  : 12,
                          color: TextColors.greyText,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const VerticalDivider(
                        thickness: 1.3,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "Movie",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 10
                                  : 12,
                          color: TextColors.whiteText,
                        ),
                      ),
                    ],
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
