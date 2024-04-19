import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/ui/post_comment_screen.dart';
import 'package:cinemax/ui/reply_screen.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
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
                    context
                        .read<CommentsBloc>()
                        .add(CommentFetchEvent(movieID));
                  },
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  color: Theme.of(context).colorScheme.primary,
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
                          if (commentsList.isNotEmpty) {
                            return SliverPadding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: _UserReview(
                                        comment: commentsList[index],
                                      ),
                                    );
                                  },
                                  childCount: commentsList.length,
                                ),
                              ),
                            );
                          } else {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: SizedBox(
                                  width: 230,
                                  height:
                                      MediaQueryHandler.screenHeight(context) -
                                          300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/box_image.svg',
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .noCommentYet,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: StringConstants
                                              .setBoldPersianFont(),
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                        textDirection:
                                            AppManager.getLnag() == 'fa'
                                                ? TextDirection.rtl
                                                : TextDirection.ltr,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .noCommentsYetCap,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: StringConstants
                                              .setMediumPersionFont(),
                                          fontSize: 12,
                                          color: TextColors.greyText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
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
              child: Text(
                "Show More",
                style: TextStyle(
                  fontFamily: StringConstants.setMediumPersionFont(),
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.tertiary,
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
                              widget.comment.username,
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
                              widget.comment.time,
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
                          "${widget.comment.rate} / 10",
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
                                    fontFamily:
                                        StringConstants.setBoldPersianFont(),
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
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
                                    fontFamily:
                                        StringConstants.setMediumPersionFont(),
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
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
                                  Text(
                                    "Warning : Spoiler Alert",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: const Color.fromARGB(
                                          255, 245, 12, 12),
                                      fontFamily: StringConstants
                                          .setMediumPersionFont(),
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
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context).colorScheme.tertiary,
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
                              fontFamily: StringConstants.setBoldPersianFont(),
                              color: Theme.of(context).colorScheme.tertiary,
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
                              fontFamily:
                                  StringConstants.setMediumPersionFont(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Transform.flip(
                          flipX: true,
                          child: GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: BlocProvider(
                                  create: (context) => CommentsBloc(
                                    locator.get(),
                                  )..add(
                                      FetchRepliesEvent(widget.comment.id),
                                    ),
                                  child: ReplyScreen(
                                    comment: widget.comment,
                                    onFocus: true,
                                  ),
                                ),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/images/icon_reply.svg',
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(
                                TextColors.greyText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.tertiary,
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
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: StringConstants.setMediumPersionFont(),
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
                    fontFamily: StringConstants.setSmallPersionFont(),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.userReview,
                  style: TextStyle(
                    fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                        ? 14
                        : 22,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontFamily: StringConstants.setBoldPersianFont(),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () async {
                    String? navresult;
                    navresult = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => CommentsBloc(locator.get()),
                          child: PostCommentScreen(
                            movieName: movieName,
                            year: year,
                            imageURL: imageURL,
                            movieID: movieID,
                          ),
                        ),
                      ),
                    );
                    if (navresult!.isNotEmpty) {
                      if (context.mounted) {
                        context
                            .read<CommentsBloc>()
                            .add(CommentFetchEvent(movieID));
                      }
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.addReview,
                    style: TextStyle(
                      fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                          ? 10
                          : 14,
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: StringConstants.setBoldPersianFont(),
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
