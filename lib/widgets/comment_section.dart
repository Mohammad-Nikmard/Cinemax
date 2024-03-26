import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  double containerHeight = 300;
  bool onMoreTapped = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: MediaQueryHandler.screenWidth(context),
      height: containerHeight,
      decoration: const BoxDecoration(
        color: PrimaryColors.softColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: LayoutBuilder(
        builder: ((context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                    child: SizedBox(
                      height: 25,
                      width: 2,
                      child: ColoredBox(color: PrimaryColors.blueAccentColor),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Comments",
                    style: TextStyle(
                      fontFamily: "MSB",
                      fontSize: 20,
                      color: TextColors.whiteText,
                    ),
                  ),
                  const SizedBox(width: 15),
                  SvgPicture.asset(
                    'assets/images/icon_arrow_right.svg',
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "title",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "MM",
                      color: TextColors.whiteText,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icon_star.svg',
                        colorFilter: const ColorFilter.mode(
                          SecondaryColors.orangeColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "7 / 10",
                        style: TextStyle(
                          fontFamily: "MR",
                          color: TextColors.greyText,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Flexible(
                child: Text(
                  "The story is presented really well and through the eyes of Oppenheimer. 90% of the movie feels like a flashback scene which though looks really cool, doesn't actually feel like something I would watch again. As in classic Nolan style 3 timelines are running simultaneously - before the atom bomb dropped, after and the present. I feel like this could have been handled better especially in the second half of the movie. The two main events in the movies the bomb explosion and the last act felt underwhelming. Actually the bomb explosion scene for which everyone was waiting so intently for was underwhelming beyond belief - Nolan should have used CGI 100%, it looked like an explosion from the 90s. There were so many characters and sub-stories that it felt like someone compressed an entire tv series into a 3 hour long movie.",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "MM",
                    color: TextColors.whiteText,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
              Visibility(
                visible: visibleCondition(constraints),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (calHeight(constraints) == 300) {
                        containerHeight = 500;
                        onMoreTapped = true;
                      }
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/images/icon_more-horizontal.svg',
                    height: 30,
                    width: 30,
                    colorFilter: const ColorFilter.mode(
                      SecondaryColors.orangeColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  double calHeight(BoxConstraints constraints) {
    if (constraints.maxHeight == 270) {
      return 300;
    } else if (constraints.maxHeight < 270) {
      return constraints.maxHeight + 30;
    } else {
      return 1000;
    }
  }

  bool visibleCondition(BoxConstraints constraints) {
    if (constraints.maxHeight < 270) {
      return false;
    } else {
      if (onMoreTapped == true) {
        return false;
      } else {
        return true;
      }
    }
  }
}
