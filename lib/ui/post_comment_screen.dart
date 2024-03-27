import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/comments/comment_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostCommentScreen extends StatefulWidget {
  const PostCommentScreen(
      {super.key,
      required this.imageURL,
      required this.movieName,
      required this.year,
      required this.movieID});
  final String imageURL;
  final String movieName;
  final String year;
  final String movieID;

  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  final headlineController = TextEditingController();
  final reviewController = TextEditingController();

  DateTime now = DateTime.now();

  bool hasSpoiler = false;
  String rateText = "3";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  movieName: widget.movieName,
                  year: widget.year,
                  imageURL: widget.imageURL,
                ),
                Text(
                  AppLocalizations.of(context)!.addRating,
                  style: const TextStyle(
                    fontSize: 18,
                    color: TextColors.whiteText,
                    fontFamily: "MSB",
                  ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 10,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: SecondaryColors.orangeColor,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      rateText = rating.toString();
                    });
                  },
                  itemSize: 25,
                  glowColor: SecondaryColors.orangeColor,
                  glowRadius: 0.5,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/tick_image.svg",
                      colorFilter: const ColorFilter.mode(
                        SecondaryColors.orangeColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      " ${AppLocalizations.of(context)!.youRated} $rateText / 10",
                      style: const TextStyle(
                        fontFamily: "MM",
                        fontSize: 14,
                        color: SecondaryColors.orangeColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.yourReview,
                  style: const TextStyle(
                    fontSize: 18,
                    color: TextColors.whiteText,
                    fontFamily: "MSB",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(
                    color: TextColors.whiteText,
                    fontFamily: "MSB",
                    fontSize: 14,
                  ),
                  controller: headlineController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.rheadline,
                    hintStyle: const TextStyle(
                        color: TextColors.greyText, fontSize: 14),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: TextColors.greyText,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: TextColors.greyText,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  maxLines: 10,
                  style: const TextStyle(
                    color: TextColors.whiteText,
                    fontFamily: "MR",
                    fontSize: 14,
                  ),
                  controller: reviewController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.rReview,
                    hintStyle: const TextStyle(
                        color: TextColors.greyText, fontSize: 14),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: TextColors.greyText,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: TextColors.greyText,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQueryHandler.screenWidth(context) - 190,
                      child: Text(
                        AppLocalizations.of(context)!.spoil,
                        style: const TextStyle(
                          fontFamily: "MR",
                          fontSize: 14,
                          color: TextColors.whiteText,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(
                                  width: 1.5, color: TextColors.whiteText),
                              shape: const CircleBorder(),
                              checkColor: Colors.transparent,
                              activeColor: TextColors.greyText,
                              value: hasSpoiler,
                              onChanged: (value) {
                                setState(() {
                                  hasSpoiler = true;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.yes,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "MR",
                                color: TextColors.whiteText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(
                                  width: 1.5, color: TextColors.whiteText),
                              shape: const CircleBorder(),
                              checkColor: Colors.transparent,
                              activeColor: TextColors.greyText,
                              value: hasSpoiler ? false : true,
                              onChanged: (value) {
                                setState(() {
                                  hasSpoiler = false;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.no,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "MR",
                                color: TextColors.whiteText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BlocConsumer<CommentsBloc, CommentsState>(
                  builder: (context, state) {
                    if (state is CommentsInitState) {
                      return SizedBox(
                        height: 54,
                        width: MediaQueryHandler.screenWidth(context),
                        child: ElevatedButton(
                          onPressed: () {
                            String finalTime =
                                "${StringConstants.months[now.month]} ${now.day}, ${now.year}";
                            if (headlineController.text.isNotEmpty &&
                                reviewController.text.isNotEmpty) {
                              context.read<CommentsBloc>().add(PostCommentEvent(
                                  widget.movieID,
                                  reviewController.text.trim(),
                                  headlineController.text,
                                  finalTime,
                                  double.parse(rateText),
                                  hasSpoiler));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: _SnackFailPostMessage(
                                    error:
                                        "You headline and review can NOT be empty.",
                                  ),
                                  duration: Duration(seconds: 3),
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.submit,
                            style: const TextStyle(
                              color: TextColors.whiteText,
                              fontSize: 16,
                              fontFamily: "MSB",
                            ),
                          ),
                        ),
                      );
                    } else if (state is CommensLoadingState) {
                      return const AppLoadingIndicator();
                    } else if (state is PostCommentResponse) {
                      return SizedBox(
                        height: 54,
                        width: MediaQueryHandler.screenWidth(context),
                        child: ElevatedButton(
                          onPressed: () {
                            String finalTime =
                                "${StringConstants.months[now.month]} ${now.day}, ${now.year}";
                            if (headlineController.text.isNotEmpty &&
                                reviewController.text.isNotEmpty) {
                              context.read<CommentsBloc>().add(PostCommentEvent(
                                  widget.movieID,
                                  reviewController.text.trim(),
                                  headlineController.text,
                                  finalTime,
                                  double.parse(rateText),
                                  hasSpoiler));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: _SnackFailPostMessage(
                                    error:
                                        "You headline and review can NOT be empty.",
                                  ),
                                  duration: Duration(seconds: 3),
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.submit,
                            style: const TextStyle(
                              color: TextColors.whiteText,
                              fontSize: 16,
                              fontFamily: "MSB",
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
                    if (state is PostCommentResponse) {
                      state.commentResponse.fold(
                        (exceptionMessage) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: _SnackFailPostMessage(
                                  error: exceptionMessage),
                              duration: const Duration(seconds: 3),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                            ),
                          );
                        },
                        (response) {
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.agree,
                            style: const TextStyle(
                              color: TextColors.whiteText,
                              fontSize: 14,
                              fontFamily: "MR",
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.conditionOfUse,
                            style: const TextStyle(
                              color: PrimaryColors.blueAccentColor,
                              fontSize: 14,
                              fontFamily: "MSB",
                            ),
                          ),
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context)!.couCaption,
                        style: const TextStyle(
                          color: TextColors.whiteText,
                          fontSize: 14,
                          fontFamily: "MR",
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

class _Header extends StatelessWidget {
  const _Header(
      {required this.imageURL, required this.movieName, required this.year});
  final String imageURL;
  final String movieName;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/images/icon_arrow_back.svg',
              height: (MediaQueryHandler.screenWidth(context) < 380) ? 24 : 30,
              width: (MediaQueryHandler.screenWidth(context) < 380) ? 24 : 30,
              colorFilter: const ColorFilter.mode(
                TextColors.whiteText,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: SizedBox(
              height: 100,
              width: 75,
              child: FittedBox(
                fit: BoxFit.cover,
                child: CachedImage(
                  imageUrl: imageURL,
                  radius: 8,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  movieName,
                  style: const TextStyle(
                    fontFamily: "MSB",
                    fontSize: 18,
                    color: TextColors.whiteText,
                  ),
                ),
              ),
              Text(
                "($year)",
                style: const TextStyle(
                  fontFamily: "MR",
                  fontSize: 16,
                  color: TextColors.greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SnackFailPostMessage extends StatelessWidget {
  const _SnackFailPostMessage({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        width: MediaQueryHandler.screenWidth(context),
        height: 60,
        decoration: const BoxDecoration(
          color: SecondaryColors.redColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Center(
            child: Text(
              error,
              style: const TextStyle(
                color: TextColors.whiteText,
                fontSize: 12,
                fontFamily: "MSB",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
