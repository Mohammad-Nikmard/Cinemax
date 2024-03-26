import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/ui/post_comment_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen(
      {super.key,
      required this.imageURL,
      required this.movieName,
      required this.year});
  final String movieName;
  final String year;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: BlocBuilder<CommentsBloc, CommentsState>(
          builder: (context, state) {
            if (state is CommensLoadingState) {
              return const AppLoadingIndicator();
            } else if (state is CommentsResponseState) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 30),
                    sliver: _CommentsHeader(
                      movieName: movieName,
                      year: year,
                      imageURL: imageURL,
                    ),
                  ),
                  state.getComments.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (commentsList) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: _UserReview(
                                  comment: commentsList[index],
                                ),
                              );
                            },
                            childCount: commentsList.length,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return Center(
              child: Text(AppLocalizations.of(context)!.state),
            );
          },
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
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          child: SizedBox(
                            height:
                                (MediaQueryHandler.screenWidth(context) < 290)
                                    ? 30
                                    : 40,
                            width:
                                (MediaQueryHandler.screenWidth(context) < 290)
                                    ? 30
                                    : 40,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: CachedImage(
                                imageUrl: comment.userThumbnail,
                                radius: 100,
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
                                    (MediaQueryHandler.screenWidth(context) <
                                            380)
                                        ? 12
                                        : 18,
                                color: TextColors.whiteText,
                                fontFamily: "MM",
                              ),
                            ),
                            Text(
                              "2024-03-26",
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
                          "${comment.rate} / 10",
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
                  comment.text,
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
  const _CommentsHeader(
      {required this.imageURL, required this.movieName, required this.year});
  final String movieName;
  final String year;
  final String imageURL;

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
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: CachedImage(
                    imageUrl: imageURL,
                    radius: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 190,
                  child: Text(
                    movieName,
                    style: TextStyle(
                      fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                          ? 12
                          : 18,
                      color: TextColors.whiteText,
                      fontFamily: "MM",
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "($year)",
                  style: TextStyle(
                    fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                        ? 10
                        : 14,
                    color: TextColors.greyText,
                    fontFamily: "MR",
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.userReview,
                  style: TextStyle(
                    fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                        ? 14
                        : 22,
                    color: TextColors.whiteText,
                    fontFamily: "MSB",
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PostCommentScreen(
                        movieName: movieName,
                        year: year,
                        imageURL: imageURL,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.addReview,
                    style: TextStyle(
                      fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                          ? 10
                          : 14,
                      color: PrimaryColors.blueAccentColor,
                      fontFamily: "MSB",
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
