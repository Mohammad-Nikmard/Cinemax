import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cast_crew_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class UpcomingMovieDetail extends StatelessWidget {
  const UpcomingMovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          const _Header(),
          const MovieHeadDetail(),
          const _Synopsis(),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: CastAndCrewWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gallery",
                    style: TextStyle(
                      fontFamily: "MSB",
                      fontSize: (screenSize.width < 350) ? 14 : 16,
                      color: TextColors.whiteText,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          const _Gallery(),
        ],
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  const _Gallery();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: SecondaryColors.greenColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            );
          },
          childCount: 30,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }
}

class _Synopsis extends StatelessWidget {
  const _Synopsis();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Synopsis",
              style: TextStyle(
                fontFamily: "MSB",
                fontSize: (screenSize.width < 350) ? 14 : 16,
                color: TextColors.whiteText,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    """
THE BATMAN is an edgy, action-packed thriller that depicts Batman in his early years, struggling to balance rage with righteousness as he investigates a disturbing mystery that has terrorized Gotham. Robert Pattinson delivers a raw, intense portrayal of Batman as a disillusioned, desperate vigilante awakened by the realization""",
                    style: TextStyle(
                      fontFamily: "MR",
                      fontSize: (screenSize.width < 350) ? 12 : 14,
                      color: TextColors.whiteText,
                    ),
                  ),
                ),
                Text(
                  "More",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: (screenSize.width < 350) ? 12 : 14,
                    color: PrimaryColors.blueAccentColor,
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

class MovieHeadDetail extends StatelessWidget {
  const MovieHeadDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: SecondaryColors.greenColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  "The Batman",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: (screenSize.width < 350) ? 14 : 16,
                    color: TextColors.whiteText,
                  ),
                ),
                const SizedBox(height: 7),
                SizedBox(
                  height: 16,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/icon_calendar.png',
                        height: (screenSize.width < 350) ? 12 : 16,
                        width: (screenSize.width < 350) ? 12 : 16,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "Relase Date: ",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize: (screenSize.width < 350) ? 10 : 12,
                          color: TextColors.greyText,
                        ),
                      ),
                      Text(
                        "March 2, 2022",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize: (screenSize.width < 350) ? 10 : 12,
                          color: TextColors.whiteText,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const VerticalDivider(
                        thickness: 1.3,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        'assets/images/icon_film.png',
                        height: (screenSize.width < 350) ? 12 : 16,
                        width: (screenSize.width < 350) ? 12 : 16,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "Action",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize: (screenSize.width < 350) ? 10 : 12,
                          color: TextColors.greyText,
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

class _Header extends StatefulWidget {
  const _Header();

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> with TickerProviderStateMixin {
  late final AnimationController controller;
  bool isLiked = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const BackLabel(),
                ),
                const Text(
                  "Title",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
                    color: TextColors.whiteText,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isLiked) {
                        controller.reverse();
                        isLiked = false;
                      } else if (!isLiked) {
                        controller.forward();
                        isLiked = true;
                      }
                    });
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const ShapeDecoration(
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      color: PrimaryColors.softColor,
                    ),
                    child: Transform.scale(
                      scale: 1.3,
                      child: Lottie.asset(
                        'assets/Animation - 1710000521327.json',
                        controller: controller,
                      ),
                    ),
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
