import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const BackLabel(),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: ColoredBox(
                          color: PrimaryColors.blueAccentColor,
                          child: SizedBox(
                            height: 185,
                            width: MediaQueryHandler.screenWidth(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
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
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: Text(
                          "Lady Gaga's Harley Quinn Speaks First Words In Joker 2 Teaser Ahead Of New Trailer Release.",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "MSB",
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        child: Text(
                          "Lady Gaga's Harley Quinn is heard for the first time in a new Joker: Folie à Deux teaser, giving the world a taste of her version of the iconic DC character. One of the upcoming Elseworlds movies from Warner Bros. Discovery and DC Studios is the highly anticipated Joker: Folie à Deux film, featuring Phoenix back as the Clown Prince of Crime. Original Joker director Todd Phillips is back to help flesh out his own little DC Universe as he continues to explore Arthur Fleck's story.",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "MR",
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
