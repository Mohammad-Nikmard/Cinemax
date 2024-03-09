import 'dart:ui';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/cast_crew_widget.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          const _MovieDetailHeader(),
          SliverToBoxAdapter(
            child: Container(
              height: 700,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0,
                  color: PrimaryColors.darkColor,
                ),
                color: PrimaryColors.darkColor,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StoryLine(),
                    CastAndCrewWidget(),
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

class _StoryLine extends StatelessWidget {
  const _StoryLine();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Story Line",
          style: TextStyle(
            fontFamily: "MSB",
            fontSize: 16,
            color: TextColors.whiteText,
          ),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                "For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk.",
                style: TextStyle(
                  fontFamily: "MR",
                  fontSize: 14,
                  color: TextColors.whiteText,
                ),
              ),
            ),
            Text(
              "More",
              style: TextStyle(
                fontFamily: "MSB",
                fontSize: 14,
                color: PrimaryColors.blueAccentColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MovieDetailHeader extends StatelessWidget {
  const _MovieDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            height: 552,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/Bg.png"),
              ),
            ),
          ),
          Container(
            height: 552,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0,
                color: PrimaryColors.darkColor,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  PrimaryColors.darkColor.withOpacity(0.6),
                  PrimaryColors.darkColor,
                ],
              ),
            ),
          ),
          const _MovieHeaderContent(),
        ],
      ),
    );
  }
}

class _MovieHeaderContent extends StatelessWidget {
  const _MovieHeaderContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/images/icon_arrow_back.png'),
              ),
              const SizedBox(
                width: 170,
                child: Text(
                  "Spider-man No way home bruh",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
                    color: TextColors.whiteText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
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
                child: Center(
                  child: Image.asset(
                    'assets/images/icon_heart.png',
                    color: SecondaryColors.redColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 287,
            width: 205,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/Bg.png"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon_calendar.png',
                  color: TextColors.greyText,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 3.0),
                const Text(
                  "2021",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 12,
                    color: TextColors.greyText,
                  ),
                ),
                const SizedBox(width: 3.0),
                const VerticalDivider(
                  thickness: 1.3,
                  color: TextColors.greyText,
                ),
                const SizedBox(width: 3.0),
                Image.asset(
                  'assets/images/icon_clock.png',
                  color: TextColors.greyText,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 3.0),
                const Text(
                  "148 Minutes",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 12,
                    color: TextColors.greyText,
                  ),
                ),
                const SizedBox(width: 3.0),
                const VerticalDivider(
                  thickness: 1.3,
                  color: TextColors.greyText,
                ),
                const SizedBox(width: 3.0),
                Image.asset(
                  'assets/images/icon_film.png',
                  color: TextColors.greyText,
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 3.0),
                const Text(
                  "Action",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 12,
                    color: TextColors.greyText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Container(
            height: 24,
            width: 55,
            decoration: const BoxDecoration(
              color: Color(0xff252836),
              borderRadius: BorderRadius.all(
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
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 115,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  ),
                  color: SecondaryColors.orangeColor,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset(
                          'assets/images/icon_play.png',
                          height: 24,
                          width: 24,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Play",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize: 16,
                          color: TextColors.whiteText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: PrimaryColors.softColor,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/icon_download.png',
                    color: SecondaryColors.orangeColor,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              GestureDetector(
                onTap: () {
                  shareDialog(context);
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: PrimaryColors.softColor,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/icon_share.png',
                      color: PrimaryColors.blueAccentColor,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> shareDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: AlertDialog(
            backgroundColor: PrimaryColors.softColor,
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xff252836),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/icon_close.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "Share to",
                        style: TextStyle(
                          fontFamily: "MSB",
                          fontSize: 18,
                          color: TextColors.whiteText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(
                      thickness: 1.33,
                      color: PrimaryColors.darkColor,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Apple.png',
                          height: 49,
                          width: 49,
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          'assets/images/Facebook.png',
                          height: 49,
                          width: 49,
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          'assets/images/Google.png',
                          height: 49,
                          width: 49,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
