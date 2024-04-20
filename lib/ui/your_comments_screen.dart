import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/user_comment.dart';
import 'package:cinemax/ui/edit_comment_screen.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class YourCommentsScreen extends StatelessWidget {
  const YourCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColors.darkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<CommentsBloc, CommentsState>(
            builder: (context, state) {
              if (state is CommensLoadingState) {
                return const AppLoadingIndicator();
              } else if (state is UserCommentResponseState) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
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
                              AppLocalizations.of(context)!.yourComments,
                              style: TextStyle(
                                fontFamily:
                                    StringConstants.setBoldPersianFont(),
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
                    state.getComments.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter(
                          child: ExceptionMessage(),
                        );
                      },
                      (commentList) {
                        if (commentList.isNotEmpty) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: _UserReview(
                                    comment: commentList[index],
                                  ),
                                );
                              },
                              childCount: commentList.length,
                            ),
                          );
                        } else {
                          return const SliverToBoxAdapter(
                            child: _EmptyCommentSection(),
                          );
                        }
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
      ),
    );
  }
}

class _UserReview extends StatelessWidget {
  const _UserReview({required this.comment});
  final UserComment comment;

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.you,
                          style: TextStyle(
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          comment.time,
                          style: TextStyle(
                            fontFamily: StringConstants.setSmallPersionFont(),
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
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
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: SizedBox(
                              height: 150,
                              width: 100,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: CachedNetworkImage(
                                  imageUrl: comment.movieThumbnail,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  comment.movieName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily:
                                        StringConstants.setBoldPersianFont(),
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                Text(
                                  comment.movieGenre,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: GestureDetector(
                              onTap: () async {
                                String? navResult;
                                navResult = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const _DeleteCommentDialog();
                                  },
                                );
                                if (navResult!.isNotEmpty) {
                                  if (context.mounted) {
                                    context.read<CommentsBloc>().add(
                                        DeleteCommentEvent(comment.id,
                                            AuthManager.readRecordID()));
                                  }
                                }
                              },
                              child: SvgPicture.asset(
                                'assets/images/icon_bin.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: GestureDetector(
                              onTap: () async {
                                String? navResult;
                                navResult = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => CommentsBloc(
                                          locator.get(), locator.get()),
                                      child: EditCommentScreen(
                                        imageURL: comment.movieThumbnail,
                                        movieName: comment.movieName,
                                        year: comment.movieYear,
                                        movieID: comment.movieID,
                                        headline: comment.headline,
                                        text: comment.text,
                                        commentId: comment.id,
                                        rate: double.parse(comment.rate),
                                        hasSpoiler: comment.spoiler,
                                      ),
                                    ),
                                  ),
                                );
                                if (navResult!.isNotEmpty) {
                                  if (context.mounted) {
                                    context.read<CommentsBloc>().add(
                                          FetchUserComments(
                                            AuthManager.readRecordID(),
                                          ),
                                        );
                                  }
                                }
                              },
                              child: SvgPicture.asset(
                                'assets/images/icon_edit_pen.svg',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.headline,
                      style: TextStyle(
                        fontSize: (MediaQueryHandler.screenWidth(context) < 380)
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
                        fontSize: (MediaQueryHandler.screenWidth(context) < 380)
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
          ),
        ),
      ),
    );
  }
}

class _DeleteCommentDialog extends StatelessWidget {
  const _DeleteCommentDialog();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/question_image.svg',
                height: 125,
                width: 125,
              ),
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.areSure,
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.deleteCommentdialog,
                style: TextStyle(
                  fontFamily: StringConstants.setMediumPersionFont(),
                  fontSize: 12,
                  color: TextColors.greyText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, "Success");
                        },
                        child: Text(
                          AppLocalizations.of(context)!.delete,
                          style: TextStyle(
                            fontFamily: StringConstants.setSmallPersionFont(),
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, "");
                        },
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 16,
                            fontFamily: StringConstants.setSmallPersionFont(),
                          ),
                        ),
                      ),
                    ),
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

class _EmptyCommentSection extends StatelessWidget {
  const _EmptyCommentSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 15),
      child: SizedBox(
        width: MediaQueryHandler.screenWidth(context) - 150,
        height: MediaQueryHandler.screenHeight(context) - 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/box_image.svg',
              ),
              Text(
                AppLocalizations.of(context)!.noCommentPosted,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.noCommentpostedCap,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: StringConstants.setMediumPersionFont(),
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
}
