import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class ReplyScreen extends StatelessWidget {
  const ReplyScreen({super.key, required this.comment});
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const BackLabel(),
                        ),
                        Text(
                          "Replies",
                          style: TextStyle(
                            fontFamily: StringConstants.setBoldPersianFont(),
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: _UserReview(comment: comment),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 20.0, bottom: 60.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: _UserReply(),
                        );
                      },
                      childCount: 3,
                    ),
                  ),
                ),
              ],
            ),
            ColoredBox(
              color: PrimaryColors.darkColor,
              child: SizedBox(
                height: 50.0,
                child: Row(
                  children: [
                    const Expanded(
                      child: SizedBox(
                        height: 55.0,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 25, left: 15),
                              hintText: "Type your reply...",
                              hintStyle: TextStyle(
                                fontFamily: "MR",
                                fontSize: 14,
                                color: TextColors.greyText,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                  width: 1.3,
                                  color: TextColors.greyText,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                  width: 1.3,
                                  color: TextColors.greyText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: SvgPicture.asset(
                        "assets/images/icon_arrow_right.svg",
                        colorFilter: const ColorFilter.mode(
                            TextColors.greyText, BlendMode.srcIn),
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

class _UserReply extends StatelessWidget {
  const _UserReply();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: ColoredBox(
        color: PrimaryColors.softColor,
        child: SizedBox(
          width: MediaQueryHandler.screenWidth(context),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: PrimaryColors.blueAccentColor,
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                fontSize:
                                    (MediaQueryHandler.screenWidth(context) <
                                            380)
                                        ? 12
                                        : 18,
                                color: Theme.of(context).colorScheme.tertiary,
                                fontFamily:
                                    StringConstants.setMediumPersionFont(),
                              ),
                            ),
                            Text(
                              "Jan 15, 2024",
                              style: TextStyle(
                                fontFamily:
                                    StringConstants.setSmallPersionFont(),
                                fontSize:
                                    (MediaQueryHandler.screenWidth(context) <
                                            290)
                                        ? 10
                                        : 16,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.more_vert,
                      color: TextColors.greyText,
                      size: 24.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.""",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "MM",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserReview extends StatelessWidget {
  const _UserReview({required this.comment});
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQueryHandler.screenWidth(context),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: SizedBox(
                          height: (MediaQueryHandler.screenWidth(context) < 290)
                              ? 30
                              : 40,
                          width: (MediaQueryHandler.screenWidth(context) < 290)
                              ? 30
                              : 40,
                          child: (comment.profile.isNotEmpty)
                              ? FittedBox(
                                  fit: BoxFit.cover,
                                  child: CachedImage(
                                    imageUrl: comment.userThumbnail,
                                    radius: 100,
                                  ),
                                )
                              : SvgPicture.asset(
                                  'assets/images/icon_user.svg',
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.tertiary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                        ),
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
                            comment.username,
                            style: TextStyle(
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 380)
                                      ? 12
                                      : 18,
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily:
                                  StringConstants.setMediumPersionFont(),
                            ),
                          ),
                          Text(
                            comment.time,
                            style: TextStyle(
                              fontFamily: StringConstants.setSmallPersionFont(),
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 290)
                                      ? 10
                                      : 16,
                              color: Theme.of(context).colorScheme.tertiary,
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
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondaryContainer,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${comment.rate} / 10",
                        style: TextStyle(
                          fontFamily: StringConstants.setSmallPersionFont(),
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
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.headline,
                        style: TextStyle(
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 380)
                                  ? 16
                                  : 20,
                          fontFamily: StringConstants.setBoldPersianFont(),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        comment.text,
                        style: TextStyle(
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 380)
                                  ? 12
                                  : 14,
                          fontFamily: StringConstants.setMediumPersionFont(),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
