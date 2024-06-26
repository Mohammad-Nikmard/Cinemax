import 'dart:ui';
import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/comment_reply.dart';
import 'package:cinemax/ui/post_comment_screen.dart';
import 'package:cinemax/ui/reply_screen.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
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
                            commentsList.sort((a, b) =>
                                b.likes.length.compareTo(a.likes.length));

                            state.getReplies.sort((a, b) => b
                                .comment.likes.length
                                .compareTo(a.comment.likes.length));

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
                                        movieID: movieID,
                                        reply: state.getReplies[index],
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
  const _UserReview(
      {required this.comment, required this.movieID, required this.reply});
  final Comment comment;
  final String movieID;
  final CommentReply reply;

  @override
  State<_UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<_UserReview>
    with TickerProviderStateMixin {
  late AnimationController likedController;
  late AnimationController dislikedController;

  late int likeNumber;
  late int dislikeNumber;

  bool spoilerCheck = false;
  late bool isLiked;
  late bool disliked;

  String menuVal = "Report";

  TextEditingController reportController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = (widget.comment.likes.contains(AuthManager.readRecordID()));
    disliked = (widget.comment.dislikes.contains(AuthManager.readRecordID()));

    likeNumber = widget.comment.likes.length;
    dislikeNumber = widget.comment.dislikes.length;

    likedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    dislikedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    if (!isLiked) {
      likedController.value = 0.0;
    } else if (isLiked) {
      likedController.value = 1.0;
    }

    if (!disliked) {
      dislikedController.value = 0.0;
    } else if (disliked) {
      dislikedController.value = 1.0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    likedController.dispose();
    dislikedController.dispose();
    reportController.dispose();
  }

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
                      if (widget.reply.replies.isNotEmpty) ...{
                        GestureDetector(
                          onTap: () async {
                            String? navresult;
                            navresult = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => CommentsBloc(
                                    locator.get(),
                                    locator.get(),
                                  )..add(
                                      FetchRepliesEvent(widget.comment.id),
                                    ),
                                  child: ReplyScreen(
                                    comment: widget.comment,
                                    onFocus: false,
                                  ),
                                ),
                              ),
                            );

                            if (navresult!.isNotEmpty) {
                              if (context.mounted) {
                                context
                                    .read<CommentsBloc>()
                                    .add(CommentFetchEvent(widget.movieID));
                              }
                            }
                          },
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 3,
                                backgroundColor: PrimaryColors.blueAccentColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${widget.reply.replies.length} reply",
                                style: const TextStyle(
                                  color: PrimaryColors.blueAccentColor,
                                  fontSize: 16,
                                  fontFamily: "MM",
                                ),
                              ),
                            ],
                          ),
                        )
                      },
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => likeEvents(),
                            child: LottieBuilder.asset(
                              'assets/Animation - 1713544475861.json',
                              repeat: false,
                              controller: likedController,
                              height: 50,
                              width: 50,
                            ),
                          ),
                          if (likeNumber != 0) ...{
                            Text(
                              "$likeNumber",
                              style: const TextStyle(
                                fontSize: 15,
                                color: TextColors.greyText,
                                fontFamily: "MM",
                              ),
                            ),
                          }
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => dislikeEvents(),
                            child: Transform.flip(
                              flipY: true,
                              child: LottieBuilder.asset(
                                'assets/Animation - 1713544475861.json',
                                repeat: false,
                                controller: dislikedController,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          if (dislikeNumber != 0) ...{
                            Text(
                              "$dislikeNumber",
                              style: const TextStyle(
                                fontSize: 15,
                                color: TextColors.greyText,
                                fontFamily: "MM",
                              ),
                            ),
                          }
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Transform.flip(
                          flipX: true,
                          child: GestureDetector(
                            onTap: () async {
                              String? navresult;
                              navresult = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => CommentsBloc(
                                      locator.get(),
                                      locator.get(),
                                    )..add(
                                        FetchRepliesEvent(widget.comment.id),
                                      ),
                                    child: ReplyScreen(
                                      comment: widget.comment,
                                      onFocus: true,
                                    ),
                                  ),
                                ),
                              );

                              if (navresult!.isNotEmpty) {
                                if (context.mounted) {
                                  context
                                      .read<CommentsBloc>()
                                      .add(CommentFetchEvent(widget.movieID));
                                }
                              }
                            },
                            child: SvgPicture.asset(
                              'assets/images/icon_reply.svg',
                              height: 16,
                              width: 16,
                              colorFilter: const ColorFilter.mode(
                                TextColors.greyText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        surfaceTintColor: PrimaryColors.darkColor,
                        color: PrimaryColors.softColor,
                        padding: const EdgeInsets.all(2),
                        onSelected: (value) {
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return BlocProvider(
                                create: (context) => CommentsBloc(
                                  locator.get(),
                                  locator.get(),
                                ),
                                child: reportSheet(),
                              );
                            },
                          );
                        },
                        iconSize: 22,
                        iconColor: TextColors.greyText,
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: menuVal,
                              child: Text(
                                menuVal,
                                style: const TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
                              ),
                            ),
                          ];
                        },
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

  dislikeEvents() {
    setState(() {
      if (!disliked) {
        context.read<CommentsBloc>().add(
            DislikeEvent(true, widget.comment.id, AuthManager.readRecordID()));
        disliked = true;
        dislikeNumber += 1;
        dislikedController.forward();

        if (disliked == true && isLiked == true) {
          context.read<CommentsBloc>().add(
              LikeEvent(false, widget.comment.id, AuthManager.readRecordID()));
          isLiked = false;
          likeNumber -= 1;
          likedController.reverse();
        }
      } else if (disliked) {
        context.read<CommentsBloc>().add(
            DislikeEvent(false, widget.comment.id, AuthManager.readRecordID()));
        disliked = false;
        dislikeNumber -= 1;
        dislikedController.reverse();
      }
    });
  }

  likeEvents() {
    setState(() {
      if (!isLiked) {
        context.read<CommentsBloc>().add(
            LikeEvent(true, widget.comment.id, AuthManager.readRecordID()));
        isLiked = true;
        likeNumber += 1;
        likedController.forward();
        if (isLiked == true && disliked == true) {
          context.read<CommentsBloc>().add(DislikeEvent(
              false, widget.comment.id, AuthManager.readRecordID()));
          disliked = false;
          dislikeNumber -= 1;
          dislikedController.reverse();
        }
      } else if (isLiked) {
        context.read<CommentsBloc>().add(
            LikeEvent(false, widget.comment.id, AuthManager.readRecordID()));
        isLiked = false;
        likeNumber -= 1;
        likedController.reverse();
      }
    });
  }

  Widget reportSheet() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        height: 475,
        width: MediaQueryHandler.screenWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25, right: 15, left: 15),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.report,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: StringConstants.setBoldPersianFont(),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.reportCap,
                style: TextStyle(
                  fontFamily: StringConstants.setSmallPersionFont(),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              TextField(
                maxLines: 9,
                controller: reportController,
                style: TextStyle(
                  fontFamily: StringConstants.setMediumPersionFont(),
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.typeSomething,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: TextColors.greyText,
                    fontFamily: StringConstants.setSmallPersionFont(),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: TextColors.greyText,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: TextColors.darkGreyText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              BlocConsumer<CommentsBloc, CommentsState>(
                builder: (context, state) {
                  if (state is CommentsInitState) {
                    return SizedBox(
                      height: 50,
                      width: MediaQueryHandler.screenWidth(context),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CommentsBloc>().add(ReportCommentEvent(
                              reportController.text.trim(),
                              replyId: null,
                              commentId: widget.comment.id));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                          style: TextStyle(
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize: 16,
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                    );
                  } else if (state is CommensLoadingState) {
                    return const AppLoadingIndicator();
                  } else if (state is ReportResponseState) {
                    return SizedBox(
                      height: 50,
                      width: MediaQueryHandler.screenWidth(context),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CommentsBloc>().add(ReportCommentEvent(
                              reportController.text.trim(),
                              replyId: null,
                              commentId: widget.comment.id));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                          style: TextStyle(
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize: 16,
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(AppLocalizations.of(context)!.state),
                  );
                },
                listener: (context, state) {
                  if (state is ReportResponseState) {
                    reportController.text = "";
                    Navigator.pop(context);
                  }
                },
              ),
            ],
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
                          create: (context) =>
                              CommentsBloc(locator.get(), locator.get()),
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
