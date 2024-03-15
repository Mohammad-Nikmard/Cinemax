import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/episode.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EpisodeWidget extends StatelessWidget {
  const EpisodeWidget({super.key, required this.episode});
  final Episode episode;

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
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: SizedBox(
                        height: 85,
                        width: 121,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: CachedImage(
                            imageUrl: episode.thumbnail,
                            radius: 10,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Episode ${episode.episodeNum}",
                          style: const TextStyle(
                            fontFamily: "MSB",
                            fontSize: 14,
                            color: TextColors.whiteText,
                          ),
                        ),
                        Text(
                          episode.timeLength,
                          style: const TextStyle(
                            fontFamily: "MM",
                            fontSize: 12,
                            color: TextColors.greyText,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(width: 15),
                    Container(
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 19.2
                          : 24,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 44
                          : 55,
                      decoration: BoxDecoration(
                        color: const Color(0xff252836).withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/icon_star.svg',
                            height: 24,
                            width: 24,
                            colorFilter: const ColorFilter.mode(
                              SecondaryColors.orangeColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            episode.rate,
                            style: const TextStyle(
                              fontFamily: "MM",
                              fontSize: 16,
                              color: SecondaryColors.orangeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  episode.description,
                  style: const TextStyle(
                    fontFamily: "MR",
                    fontSize: 14,
                    color: TextColors.whiteText,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
