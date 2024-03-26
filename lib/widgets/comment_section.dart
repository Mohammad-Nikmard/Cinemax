import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.comment});
  final Comment comment;

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
                  Text(
                    AppLocalizations.of(context)!.comments,
                    style: const TextStyle(
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
                  SizedBox(
                    width: MediaQueryHandler.screenWidth(context) - 180,
                    child: Text(
                      widget.comment.headline,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "MSB",
                        color: TextColors.whiteText,
                      ),
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
                      Text(
                        "${widget.comment.rate} / 10",
                        style: const TextStyle(
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
              Flexible(
                child: Text(
                  widget.comment.text,
                  style: const TextStyle(
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
