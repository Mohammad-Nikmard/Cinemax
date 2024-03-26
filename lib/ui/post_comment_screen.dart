import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class PostCommentScreen extends StatefulWidget {
  const PostCommentScreen({super.key});

  @override
  State<PostCommentScreen> createState() => _PostCommentScreenState();
}

class _PostCommentScreenState extends State<PostCommentScreen> {
  final headlineController = TextEditingController();
  final reviewController = TextEditingController();

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
                const _Header(),
                const Text(
                  "YOUR RATING",
                  style: TextStyle(
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
                      " You rated $rateText / 10",
                      style: const TextStyle(
                        fontFamily: "MM",
                        fontSize: 14,
                        color: SecondaryColors.orangeColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "YOUR REVIEW",
                  style: TextStyle(
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
                  decoration: const InputDecoration(
                    hintText: "Write a headline for your review here",
                    hintStyle:
                        TextStyle(color: TextColors.greyText, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: TextColors.greyText,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
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
                  decoration: const InputDecoration(
                    hintText: "Write your review here",
                    hintStyle:
                        TextStyle(color: TextColors.greyText, fontSize: 14),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: TextColors.greyText,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
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
                      child: const Text(
                        "Does your review contain spoiler? ",
                        style: TextStyle(
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
                            const Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "MR",
                                color: TextColors.whiteText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
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
                            const Text(
                              "No",
                              style: TextStyle(
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
                SizedBox(
                  height: 54,
                  width: MediaQueryHandler.screenWidth(context),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: TextColors.whiteText,
                        fontSize: 16,
                        fontFamily: "MSB",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "I agree to the ",
                            style: TextStyle(
                              color: TextColors.whiteText,
                              fontSize: 14,
                              fontFamily: "MR",
                            ),
                          ),
                          Text(
                            "Condition of use.",
                            style: TextStyle(
                              color: PrimaryColors.blueAccentColor,
                              fontSize: 14,
                              fontFamily: "MSB",
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "The data i'm submitting is true and not copyrighted by a third party.",
                        style: TextStyle(
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
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: SizedBox(
              height: 100,
              width: 75,
              child: ColoredBox(
                color: PrimaryColors.blueAccentColor,
              ),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Oppenheimer",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 18,
                  color: TextColors.whiteText,
                ),
              ),
              Text(
                "(2023)",
                style: TextStyle(
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
