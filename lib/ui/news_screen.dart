import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/news_detail_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CustomScrollView(
            slivers: [
              _Header(),
              _NewsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const BackLabel(),
            ),
            const Text(
              "News",
              style: TextStyle(
                fontFamily: "MSB",
                fontSize: 16,
                color: TextColors.whiteText,
              ),
            ),
            const SizedBox(
              height: 32,
              width: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsWidget extends StatelessWidget {
  const _NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 15),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const NewsDetailScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: ColoredBox(
                    color: PrimaryColors.softColor,
                    child: SizedBox(
                      width: MediaQueryHandler.screenWidth(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: ColoredBox(
                              color: PrimaryColors.blueAccentColor,
                              child: SizedBox(
                                height: 160,
                                width: MediaQueryHandler.screenWidth(context),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icon_calendar.svg',
                                  height: 16,
                                  width: 16,
                                  colorFilter: const ColorFilter.mode(
                                    TextColors.greyText,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Apr 3, 2024",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "MR",
                                    color: TextColors.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 10, top: 10, right: 10, bottom: 20),
                            child: Text(
                              "Godzilla x Kong Box Office Roars Past Major Global Milestone In Less Than 1 Week.",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "MSB",
                                color: TextColors.whiteText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: 5,
        ),
      ),
    );
  }
}
