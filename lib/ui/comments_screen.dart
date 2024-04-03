import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/ui/post_comment_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen(
      {super.key,
      required this.imageURL,
      required this.movieName,
      required this.year,
      required this.movieID});
  final String movieName;
  final String year;
  final String imageURL;
  final String movieID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: BlocBuilder<CommentsBloc, CommentsState>(
          builder: (context, state) {
            if (state is CommensLoadingState) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: const CommentsLoading(),
              );
            } else if (state is CommentsResponseState) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CommentsBloc>().add(CommentFetchEvent(movieID));
                },
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                color: PrimaryColors.blueAccentColor,
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(bottom: 30),
                      sliver: _CommentsHeader(
                        movieName: movieName,
                        year: year,
                        imageURL: imageURL,
                        movieID: movieID,
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
                    state.getComments.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter(
                          child: ExceptionMessage(),
                        );
                      },
                      (commentsList) {
                        return MoreCommentWidget(
                          movieID: movieID,
                          getComments: commentsList,
                        );
                      },
                    ),
                  ],
                ),
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

class MoreCommentWidget extends StatefulWidget {
  const MoreCommentWidget(
      {super.key, required this.movieID, required this.getComments});
  final String movieID;
  final List<Comment> getComments;

  @override
  State<MoreCommentWidget> createState() => _MoreCommentWidgetState();
}

class _MoreCommentWidgetState extends State<MoreCommentWidget> {
  int page = 30;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Visibility(
        visible: (widget.getComments.length == page) ? true : false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 25, right: 45, left: 45),
          child: SizedBox(
            height: 46,
            width: MediaQueryHandler.screenWidth(context),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  page += 30;
                });
                context
                    .read<CommentsBloc>()
                    .add(ShowMoreCommentsEvent(page, widget.movieID));
              },
              child: const Text(
                "Show More",
                style: TextStyle(
                  fontFamily: "MM",
                  fontSize: 16,
                  color: TextColors.whiteText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserReview extends StatefulWidget {
  const _UserReview({required this.comment});
  final Comment comment;

  @override
  State<_UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<_UserReview> {
  bool spoilerCheck = false;
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
                            height:
                                (MediaQueryHandler.screenWidth(context) < 290)
                                    ? 30
                                    : 40,
                            width:
                                (MediaQueryHandler.screenWidth(context) < 290)
                                    ? 30
                                    : 40,
                            child: (widget.comment.profile.isNotEmpty)
                                ? FittedBox(
                                    fit: BoxFit.cover,
                                    child: CachedImage(
                                      imageUrl: widget.comment.userThumbnail,
                                      radius: 100,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    'assets/images/icon_user.svg',
                                    fit: BoxFit.cover,
                                    colorFilter: const ColorFilter.mode(
                                      TextColors.whiteText,
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
                              widget.comment.username,
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
                              widget.comment.time,
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
                          "${widget.comment.rate} / 10",
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
                (widget.comment.spoiler)
                    ? Column(
                        children: [
                          Visibility(
                            visible: (spoilerCheck),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.comment.headline,
                                  style: TextStyle(
                                    fontSize: (MediaQueryHandler.screenWidth(
                                                context) <
                                            380)
                                        ? 16
                                        : 20,
                                    fontFamily: "MSB",
                                    color: TextColors.whiteText,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  widget.comment.text,
                                  style: TextStyle(
                                    fontSize: (MediaQueryHandler.screenWidth(
                                                context) <
                                            380)
                                        ? 12
                                        : 14,
                                    fontFamily: "MM",
                                    color: TextColors.whiteText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: (!spoilerCheck),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Warning : Spoiler Alert",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 245, 12, 12),
                                      fontFamily: "MM",
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        spoilerCheck = true;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/icon_arrow_down.svg',
                                      height: 30,
                                      width: 30,
                                      colorFilter: const ColorFilter.mode(
                                        TextColors.whiteText,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.comment.headline,
                            style: TextStyle(
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 380)
                                      ? 16
                                      : 20,
                              fontFamily: "MSB",
                              color: TextColors.whiteText,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            widget.comment.text,
                            style: TextStyle(
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 380)
                                      ? 12
                                      : 14,
                              fontFamily: "MM",
                              color: TextColors.whiteText,
                            ),
                          ),
                        ],
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
      {required this.imageURL,
      required this.movieName,
      required this.year,
      required this.movieID});
  final String movieName;
  final String year;
  final String imageURL;
  final String movieID;

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
                      screen: BlocProvider(
                        create: (context) => CommentsBloc(locator.get()),
                        child: PostCommentScreen(
                          movieName: movieName,
                          year: year,
                          imageURL: imageURL,
                          movieID: movieID,
                        ),
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

class CommentsLoading extends StatelessWidget {
  const CommentsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerSkelton(
                  height: 140,
                  width: 105,
                  radius: 15,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerSkelton(
                      height: 20,
                      width: 90,
                      radius: 5,
                    ),
                    SizedBox(height: 10),
                    ShimmerSkelton(
                      height: 20,
                      width: 100,
                      radius: 5,
                    ),
                    SizedBox(height: 10),
                    ShimmerSkelton(
                      height: 20,
                      width: 110,
                      radius: 5,
                    ),
                    SizedBox(height: 10),
                    ShimmerSkelton(
                      height: 20,
                      width: 100,
                      radius: 5,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            ShimmerSkelton(
              height: 190,
              width: MediaQueryHandler.screenWidth(context),
              radius: 15,
            ),
            const SizedBox(height: 15),
            ShimmerSkelton(
              height: 210,
              width: MediaQueryHandler.screenWidth(context),
              radius: 15,
            ),
            const SizedBox(height: 15),
            ShimmerSkelton(
              height: 230,
              width: MediaQueryHandler.screenWidth(context),
              radius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
