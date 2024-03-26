import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 30),
              sliver: _CommentsHeader(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: _UserReview(),
                    );
                  },
                  childCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserReview extends StatelessWidget {
  const _UserReview({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: SizedBox(
        width: MediaQueryHandler.screenWidth(context),
        child: ColoredBox(
          color: PrimaryColors.softColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: (MediaQueryHandler.screenWidth(context) < 290)
                              ? 15
                              : 20,
                          backgroundColor: PrimaryColors.blueAccentColor,
                        ),
                        SizedBox(
                          width: (MediaQueryHandler.screenWidth(context) < 380)
                              ? 5
                              : 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "name of the user",
                              style: TextStyle(
                                fontSize:
                                    (MediaQueryHandler.screenWidth(context) <
                                            380)
                                        ? 12
                                        : 18,
                                color: TextColors.whiteText,
                                fontFamily: "MM",
                              ),
                            ),
                            Text(
                              "date released",
                              style: TextStyle(
                                fontFamily: "MR",
                                fontSize:
                                    (MediaQueryHandler.screenWidth(context) <
                                            290)
                                        ? 10
                                        : 16,
                                color: TextColors.whiteText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/icon_star.svg',
                          height: (MediaQueryHandler.screenWidth(context) < 290)
                              ? 18
                              : 30,
                          width: (MediaQueryHandler.screenWidth(context) < 290)
                              ? 18
                              : 30,
                          colorFilter: const ColorFilter.mode(
                            SecondaryColors.orangeColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "7 / 10",
                          style: TextStyle(
                            fontFamily: "MR",
                            color: TextColors.greyText,
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 380)
                                    ? 14
                                    : 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  "You'll have to have your wits about you and your brain fully switched on watching Oppenheimer as it could easily get away from a nonattentive viewer. This is intelligent filmmaking which shows it's audience great respect. It fires dialogue packed with information at a relentless pace and jumps to very different times in Oppenheimer's life continuously through it's 3 hour runtime. There are visual clues to guide the viewer through these times but again you'll have to get to grips with these quite quickly. This relentlessness helps to express the urgency with which the US attacked it's chase for the atomic bomb before Germany could do the same. An absolute career best performance from (the consistenly brilliant) Cillian Murphy anchors the film. This is a nailed on Oscar performance. In fact the whole cast are fantastic (apart maybe for the sometimes overwrought Emily Blunt performance). RDJ is also particularly brilliant in a return to proper acting after his decade or so of calling it in. The screenplay is dense and layered (I'd say it was a thick as a Bible), cinematography is quite stark and spare for the most part but imbued with rich, lucious colour in moments (especially scenes with Florence Pugh), the score is beautiful at times but mostly anxious and oppressive, adding to the relentless pacing. The 3 hour runtime flies by. All in all I found it an intense, taxing but highly rewarding watch. This is film making at it finest. A really great watch.",
                  style: TextStyle(
                    fontSize: (MediaQueryHandler.screenWidth(context) < 380)
                        ? 12
                        : 14,
                    fontFamily: "MM",
                    color: TextColors.whiteText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentsHeader extends StatelessWidget {
  const _CommentsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                'assets/images/icon_arrow_back.svg',
                height:
                    (MediaQueryHandler.screenWidth(context) < 380) ? 24 : 30,
                width: (MediaQueryHandler.screenWidth(context) < 380) ? 24 : 30,
                colorFilter: const ColorFilter.mode(
                  TextColors.whiteText,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(
              width: (MediaQueryHandler.screenWidth(context) < 380) ? 15 : 30,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: SizedBox(
                height:
                    (MediaQueryHandler.screenWidth(context) < 380) ? 120 : 140,
                width:
                    (MediaQueryHandler.screenWidth(context) < 380) ? 85 : 105,
                child: const ColoredBox(
                  color: PrimaryColors.blueAccentColor,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Oppenheimer",
                      style: TextStyle(
                        fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                            ? 12
                            : 18,
                        color: TextColors.whiteText,
                        fontFamily: "MM",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "(2023)",
                      style: TextStyle(
                        fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                            ? 10
                            : 14,
                        color: TextColors.greyText,
                        fontFamily: "MR",
                      ),
                    ),
                  ],
                ),
                Text(
                  "Users review",
                  style: TextStyle(
                    fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                        ? 14
                        : 22,
                    color: TextColors.whiteText,
                    fontFamily: "MSB",
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
