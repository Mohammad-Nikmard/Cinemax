import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
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
  double? numLines;
  double? containerHeight;
  bool? onMoreTapped;

  @override
  void initState() {
    super.initState();
    numLines = (widget.comment.text.length) / 20;
    containerHeight = setContainerHeight();
    onMoreTapped = visibleCondition();
  }

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
      child: Column(
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
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: StringConstants.setBoldPersianFont(),
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
                    style: TextStyle(
                      fontFamily: StringConstants.setSmallPersionFont(),
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
              style: TextStyle(
                fontSize: 14,
                fontFamily: StringConstants.setMediumPersionFont(),
                color: TextColors.whiteText,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
          Visibility(
            visible: onMoreTapped!,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (setContainerHeight() == 180) {
                    containerHeight = 230;
                    onMoreTapped = false;
                  } else if (setContainerHeight() == 300) {
                    containerHeight = 400;
                    onMoreTapped = false;
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
      ),
    );
  }

  bool visibleCondition() {
    if (containerHeight! > 150) {
      return true;
    } else {
      return false;
    }
  }

  double setContainerHeight() {
    if (numLines! < 1.5) {
      return 150;
    } else if (numLines! >= 1.5 && numLines! <= 5) {
      return 180;
    } else {
      return 300;
    }
  }
}

class EmptyCommentSection extends StatelessWidget {
  const EmptyCommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        child: ColoredBox(
          color: PrimaryColors.softColor,
          child: SizedBox(
            width: MediaQueryHandler.screenWidth(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          child:
                              ColoredBox(color: PrimaryColors.blueAccentColor),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.comments,
                        style: TextStyle(
                          fontFamily: StringConstants.setBoldPersianFont(),
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
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.noCommentHere,
                    style: TextStyle(
                      fontFamily: StringConstants.setBoldPersianFont(),
                      fontSize: 20,
                      color: TextColors.whiteText,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppLocalizations.of(context)!.noCommentCap,
                    style: TextStyle(
                      fontFamily: StringConstants.setSmallPersionFont(),
                      fontSize: 16,
                      color: TextColors.whiteText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
