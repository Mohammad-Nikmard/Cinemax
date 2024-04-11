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

class EditCommentScreen extends StatefulWidget {
  const EditCommentScreen({
    super.key,
    required this.imageURL,
    required this.movieName,
    required this.year,
    required this.movieID,
    required this.headline,
    required this.text,
    required this.commentId,
    required this.rate,
    required this.hasSpoiler,
  });
  final String imageURL;
  final String movieName;
  final String year;
  final String movieID;
  final String headline;
  final String text;
  final String commentId;
  final double rate;
  final bool hasSpoiler;

  @override
  State<EditCommentScreen> createState() => _EditCommentScreenState();
}

class _EditCommentScreenState extends State<EditCommentScreen> {
  DateTime now = DateTime.now();
  bool? hasSpoiler;
  String? rateText;
  TextEditingController? headlineController;
  TextEditingController? reviewController;

  @override
  void initState() {
    super.initState();
    hasSpoiler = widget.hasSpoiler;
    rateText = widget.rate.toString();
    headlineController = TextEditingController(text: widget.headline);
    reviewController = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.ltr,
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
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: StringConstants.setBoldPersianFont(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: double.parse(rateText!),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 10,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        rateText = rating.toString();
                      });
                    },
                    itemSize: 25,
                    glowColor: Theme.of(context).colorScheme.secondaryContainer,
                    glowRadius: 0.5,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/tick_image.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondaryContainer,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        " ${AppLocalizations.of(context)!.youRated} $rateText / 10",
                        style: TextStyle(
                          fontFamily: StringConstants.setMediumPersionFont(),
                          fontSize: 14,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.yourReview,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: StringConstants.setBoldPersianFont(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: StringConstants.setBoldPersianFont(),
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
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontFamily: StringConstants.setSmallPersionFont(),
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
                          style: TextStyle(
                            fontFamily: StringConstants.setSmallPersionFont(),
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                side: BorderSide(
                                  width: 1.5,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
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
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily:
                                      StringConstants.setSmallPersionFont(),
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Row(
                            children: [
                              Checkbox(
                                side: BorderSide(
                                  width: 1.5,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                shape: const CircleBorder(),
                                checkColor: Colors.transparent,
                                activeColor: TextColors.greyText,
                                value: hasSpoiler! ? false : true,
                                onChanged: (value) {
                                  setState(() {
                                    hasSpoiler = false;
                                  });
                                },
                              ),
                              Text(
                                AppLocalizations.of(context)!.no,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily:
                                      StringConstants.setSmallPersionFont(),
                                  color: Theme.of(context).colorScheme.tertiary,
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
                              _eventHandler(
                                  headlineController!, reviewController!);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.submit,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 16,
                                fontFamily:
                                    StringConstants.setBoldPersianFont(),
                              ),
                            ),
                          ),
                        );
                      } else if (state is CommensLoadingState) {
                        return const AppLoadingIndicator();
                      } else if (state is CommentUpdateResponseState) {
                        return SizedBox(
                          height: 54,
                          width: MediaQueryHandler.screenWidth(context),
                          child: ElevatedButton(
                            onPressed: () {
                              _eventHandler(
                                  headlineController!, reviewController!);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.submit,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 16,
                                fontFamily:
                                    StringConstants.setBoldPersianFont(),
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
                      if (state is CommentUpdateResponseState) {
                        state.response.fold(
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
                            Navigator.pop(context, "Success");
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _eventHandler(TextEditingController headline, TextEditingController review) {
    String finalTime =
        "${StringConstants.months[now.month]} ${now.day}, ${now.year}";
    if (headline.text.isNotEmpty && review.text.isNotEmpty) {
      context.read<CommentsBloc>().add(
            EditCommentEvent(
              widget.commentId,
              review.text.trim(),
              headline.text.trim(),
              finalTime,
              double.parse(rateText!),
              hasSpoiler!,
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: _SnackFailPostMessage(
            error: "You headline and review can NOT be empty.",
          ),
          duration: Duration(seconds: 3),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      );
    }
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
              Navigator.pop(context, "");
            },
            child: SvgPicture.asset(
              'assets/images/icon_arrow_back.svg',
              height: (MediaQueryHandler.screenWidth(context) < 380) ? 24 : 30,
              width: (MediaQueryHandler.screenWidth(context) < 380) ? 24 : 30,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.tertiary,
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
                  style: TextStyle(
                    fontFamily: StringConstants.setBoldPersianFont(),
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Text(
                "($year)",
                style: TextStyle(
                  fontFamily: StringConstants.setSmallPersionFont(),
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
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 12,
                fontFamily: StringConstants.setBoldPersianFont(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
