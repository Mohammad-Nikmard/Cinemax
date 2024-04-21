import 'dart:ui';

import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/comment.dart';
import 'package:cinemax/data/model/user_reply.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class ReplyScreen extends StatefulWidget {
  const ReplyScreen({
    super.key,
    required this.comment,
    required this.onFocus,
  });
  final Comment comment;
  final bool onFocus;

  @override
  State<ReplyScreen> createState() => _ReplyScreenState();
}

class _ReplyScreenState extends State<ReplyScreen> {
  TextEditingController commentController = TextEditingController();
  DateTime now = DateTime.now();
  String controllerText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            RefreshIndicator(
              onRefresh: () async {
                context.read<CommentsBloc>().add(
                      FetchRepliesEvent(widget.comment.id),
                    );
              },
              backgroundColor: PrimaryColors.softColor,
              color: PrimaryColors.blueAccentColor,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context, "Success");
                            },
                            child: const BackLabel(),
                          ),
                          Text(
                            AppLocalizations.of(context)!.replies,
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
                      child: _UserReview(comment: widget.comment),
                    ),
                  ),
                  BlocBuilder<CommentsBloc, CommentsState>(
                    builder: (context, state) {
                      if (state is CommensLoadingState) {
                        return SliverToBoxAdapter(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[100]!,
                            child: const ReplyLoading(),
                          ),
                        );
                      }
                      if (state is ReplyresponseState) {
                        return state.getreplies.fold(
                          (exceptionMessage) {
                            return const SliverToBoxAdapter(
                              child: ExceptionMessage(),
                            );
                          },
                          (replyList) {
                            return SliverPadding(
                              padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                  top: 20.0,
                                  bottom: 60.0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: _UserReply(
                                        reply: replyList[index],
                                      ),
                                    );
                                  },
                                  childCount: replyList.length,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(AppLocalizations.of(context)!.state),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: PrimaryColors.darkColor,
              child: SizedBox(
                height: 50.0,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 55.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                controllerText = value;
                              });
                            },
                            controller: commentController,
                            autofocus: widget.onFocus,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(top: 25, left: 15),
                              hintText:
                                  AppLocalizations.of(context)!.typeYourReply,
                              hintStyle: TextStyle(
                                fontFamily:
                                    StringConstants.setSmallPersionFont(),
                                fontSize: 14,
                                color: TextColors.greyText,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                  width: 1.3,
                                  color: TextColors.greyText,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
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
                      child: GestureDetector(
                        onTap: () {
                          if (commentController.text.trim().isNotEmpty) {
                            String finalTime =
                                "${StringConstants.months[now.month]} ${now.day}, ${now.year}";
                            context.read<CommentsBloc>().add(
                                  PostReplyEvent(
                                    commentController.text,
                                    finalTime,
                                    AuthManager.readRecordID(),
                                    widget.comment.id,
                                  ),
                                );
                          }

                          setState(() {
                            commentController.text = "";
                          });
                        },
                        child: SvgPicture.asset(
                          "assets/images/icon_arrow_right.svg",
                          colorFilter: ColorFilter.mode(
                            (controllerText.isEmpty)
                                ? TextColors.greyText
                                : PrimaryColors.blueAccentColor,
                            BlendMode.srcIn,
                          ),
                        ),
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

class _UserReply extends StatefulWidget {
  const _UserReply({required this.reply});
  final UserReply reply;

  @override
  State<_UserReply> createState() => _UserReplyState();
}

class _UserReplyState extends State<_UserReply> with TickerProviderStateMixin {
  late AnimationController likecontroller;
  late AnimationController dislikecontroller;
  late bool liked;
  late bool disliked;

  late int likeNumber;
  late int dislikeNumber;

  String menuVal = "Report";

  TextEditingController reportController = TextEditingController();

  @override
  void initState() {
    super.initState();
    likeNumber = widget.reply.likes.length;
    dislikeNumber = widget.reply.dislikes.length;

    liked = (widget.reply.likes.contains(AuthManager.readRecordID()));
    disliked = (widget.reply.dislikes.contains(AuthManager.readRecordID()));

    likecontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    dislikecontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    if (!liked) {
      likecontroller.value = 0.0;
    } else if (liked) {
      likecontroller.value = 1.0;
    }

    if (!disliked) {
      dislikecontroller.value = 0.0;
    } else if (disliked) {
      dislikecontroller.value = 1.0;
    }
  }

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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            child: (widget.reply.thumbnail.isNotEmpty)
                                ? FittedBox(
                                    fit: BoxFit.cover,
                                    child: CachedImage(
                                      imageUrl: widget.reply.userThumbnail,
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
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.reply.userName,
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
                              widget.reply.date,
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
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.reply.text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "MM",
                  ),
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => likeEvent(),
                          child: LottieBuilder.asset(
                            'assets/Animation - 1713544475861.json',
                            height: 50,
                            width: 50,
                            controller: likecontroller,
                            repeat: false,
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
                        Transform.flip(
                          flipY: true,
                          child: GestureDetector(
                            onTap: () => dislikeEvent(),
                            child: LottieBuilder.asset(
                              'assets/Animation - 1713544475861.json',
                              height: 50,
                              width: 50,
                              controller: dislikecontroller,
                              repeat: false,
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dislikeEvent() {
    setState(() {
      if (!disliked) {
        context.read<CommentsBloc>().add(ReplyDislikeEvent(
            widget.reply.id, AuthManager.readRecordID(), true));
        disliked = true;
        dislikeNumber += 1;
        dislikecontroller.forward();

        if (disliked == true && liked == true) {
          context.read<CommentsBloc>().add(ReplyLikeEvent(
              widget.reply.id, AuthManager.readRecordID(), false));
          liked = false;
          likeNumber -= 1;
          likecontroller.reverse();
        }
      } else if (disliked) {
        context.read<CommentsBloc>().add(ReplyDislikeEvent(
            widget.reply.id, AuthManager.readRecordID(), false));
        disliked = false;
        dislikeNumber -= 1;
        dislikecontroller.reverse();
      }
    });
  }

  likeEvent() {
    setState(() {
      if (!liked) {
        context.read<CommentsBloc>().add(
            ReplyLikeEvent(widget.reply.id, AuthManager.readRecordID(), true));
        liked = true;
        likeNumber += 1;
        likecontroller.forward();

        if (liked == true && disliked == true) {
          context.read<CommentsBloc>().add(ReplyDislikeEvent(
              widget.reply.id, AuthManager.readRecordID(), false));
          disliked = false;
          dislikeNumber -= 1;
          dislikecontroller.reverse();
        }
      } else if (liked) {
        context.read<CommentsBloc>().add(
            ReplyLikeEvent(widget.reply.id, AuthManager.readRecordID(), false));
        liked = false;
        likeNumber -= 1;
        likecontroller.reverse();
      }
    });
  }

  Widget reportSheet() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        height: 450,
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
                maxLines: 8,
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
              const SizedBox(height: 50),
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
                              commentId: null,
                              replyId: widget.reply.id));
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
                              commentId: null,
                              replyId: widget.reply.id));
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

class ReplyLoading extends StatelessWidget {
  const ReplyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 60),
      child: Column(
        children: [
          ShimmerSkelton(
            height: 150,
            width: MediaQueryHandler.screenWidth(context),
            radius: 15,
          ),
          const SizedBox(height: 12),
          ShimmerSkelton(
            height: 150,
            width: MediaQueryHandler.screenWidth(context),
            radius: 15,
          ),
          const SizedBox(height: 12),
          ShimmerSkelton(
            height: 150,
            width: MediaQueryHandler.screenWidth(context),
            radius: 15,
          ),
        ],
      ),
    );
  }
}
