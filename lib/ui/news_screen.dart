import 'package:cinemax/bloc/news/news_bloc.dart';
import 'package:cinemax/bloc/news/news_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/news.dart';
import 'package:cinemax/ui/news_detail_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoadingState) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[100]!,
                  child: const NewsLoading(),
                );
              } else if (state is NewsResponseState) {
                return CustomScrollView(
                  slivers: [
                    const _Header(),
                    state.getNews.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter(
                          child: ExceptionMessage(),
                        );
                      },
                      (newsList) {
                        return _NewsWidget(
                          newsList: newsList,
                        );
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
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
              AppLocalizations.of(context)!.news,
              style: const TextStyle(
                fontFamily: "MSB",
                fontSize: 16,
                color: TextColors.whiteText,
              ),
            ),
            const SizedBox(
              height: 32,
              width: 32,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsWidget extends StatelessWidget {
  const _NewsWidget({required this.newsList});
  final List<News> newsList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 15),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: NewsDetailScreen(
                      news: newsList[index],
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: ColoredBox(
                    color: PrimaryColors.softColor,
                    child: SizedBox(
                      width: MediaQueryHandler.screenWidth(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: SizedBox(
                              height: 160,
                              width: MediaQueryHandler.screenWidth(context),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: CachedImage(
                                  imageUrl: newsList[index].thumbnail,
                                  radius: 0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icon_calendar.svg',
                                  height: 16,
                                  width: 16,
                                  colorFilter: const ColorFilter.mode(
                                    TextColors.greyText,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  newsList[index].date,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "MR",
                                    color: TextColors.greyText,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  AppLocalizations.of(context)!.publisher,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "MR",
                                    color: TextColors.greyText,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: CachedImage(
                                      imageUrl: newsList[index].publisher,
                                      radius: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10, bottom: 20),
                            child: Text(
                              newsList[index].title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: "MSB",
                                color: TextColors.whiteText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: newsList.length,
        ),
      ),
    );
  }
}

class NewsLoading extends StatelessWidget {
  const NewsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerSkelton(
                  height: 32,
                  width: 32,
                  radius: 100,
                ),
                ShimmerSkelton(
                  height: 20,
                  width: 100,
                  radius: 5,
                ),
                SizedBox(
                  height: 32,
                  width: 32,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ShimmerSkelton(
            height: 200,
            width: MediaQueryHandler.screenWidth(context),
            radius: 15,
          ),
          const SizedBox(height: 15),
          ShimmerSkelton(
            height: 200,
            width: MediaQueryHandler.screenWidth(context),
            radius: 15,
          ),
          const SizedBox(height: 15),
          ShimmerSkelton(
            height: 200,
            width: MediaQueryHandler.screenWidth(context),
            radius: 15,
          ),
        ],
      ),
    );
  }
}
