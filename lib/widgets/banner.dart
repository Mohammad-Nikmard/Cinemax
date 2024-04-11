import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/banner.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerContainer extends StatefulWidget {
  const BannerContainer({super.key, required this.bannerList});
  final List<BannerModel> bannerList;

  @override
  State<BannerContainer> createState() => _BannerContainerState();
}

class _BannerContainerState extends State<BannerContainer> {
  final PageController controller =
      PageController(viewportFraction: 0.8, initialPage: 2);

  @override
  Widget build(BuildContext context) {
    widget.bannerList.shuffle();
    return Column(
      children: [
        SizedBox(
          height: 155,
          child: PageView.builder(
            itemCount: widget.bannerList.length,
            controller: controller,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 154,
                width: 315,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.5),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        child: SizedBox(
                          height: 154,
                          width: 305,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: CachedImage(
                              imageUrl: widget.bannerList[index].thumbnail,
                              radius: 16,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 154,
                        width: 305,
                        decoration: BoxDecoration(
                          color: PrimaryColors.darkColor.withOpacity(0.3),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 20,
                        child: SizedBox(
                          width: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 154
                              : 214,
                          child: Text(
                            widget.bannerList[index].title,
                            style: TextStyle(
                              fontFamily: "MSB",
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 350)
                                      ? 12
                                      : 16,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Text(
                          "On ${widget.bannerList[index].relaseMonth} ${widget.bannerList[index].releaseDate}, ${widget.bannerList[index].relaseYear}",
                          style: TextStyle(
                            fontFamily: "MM",
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 8
                                    : 12,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: widget.bannerList.length,
          effect: ExpandingDotsEffect(
            spacing: 8.0,
            radius: 7.0,
            dotWidth: 10.0,
            dotHeight: 8.0,
            strokeWidth: 1.5,
            dotColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            activeDotColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
