import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/news/news_bloc.dart';
import 'package:cinemax/bloc/news/news_event.dart';
import 'package:cinemax/bloc/upcomings/upcomings_bloc.dart';
import 'package:cinemax/bloc/upcomings/upcomings_event.dart';
import 'package:cinemax/bloc/upcomings/upcomings_state.dart';
import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/upcomings.dart';
import 'package:cinemax/ui/news_screen.dart';
import 'package:cinemax/ui/upcoming_movie_detail.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingsScreen extends StatelessWidget {
  const UpcomingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<UpcomingsBloc, UpcomingsState>(
        builder: (context, state) {
          if (state is UpcomingsLoadingState) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[100]!,
              child: const UpcomingLoading(),
            );
          } else if (state is UpcomingsResponseState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<UpcomingsBloc>()
                        .add(UpcomingsDataRequestEvent());
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  color: Theme.of(context).colorScheme.primary,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomScrollView(
                      slivers: [
                        const _Header(),
                        state.getUpcomingsList.fold(
                          (exceptionMessage) {
                            return const SliverToBoxAdapter(
                              child: ExceptionMessage(),
                            );
                          },
                          (upList) {
                            return _UpcomingsList(
                              upList: upList,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Text(AppLocalizations.of(context)!.state),
          );
        },
      ),
    );
  }
}

class _UpcomingsList extends StatelessWidget {
  const _UpcomingsList({required this.upList});
  final List<Upcomings> upList;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _UpcomingChip(
              upcomingsItem: upList[index],
            ),
          );
        },
        childCount: upList.length,
      ),
    );
  }
}

class _UpcomingChip extends StatelessWidget {
  const _UpcomingChip({required this.upcomingsItem});
  final Upcomings upcomingsItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: BlocProvider<WishlistBloc>.value(
            value: locator.get<WishlistBloc>(),
            child: UpcomingMovieDetail(
              upcomingItem: upcomingsItem,
            ),
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: SizedBox(
        height: 224,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 168,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: CachedImage(
                    imageUrl: upcomingsItem.thumbnail,
                    radius: 16,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  upcomingsItem.name,
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(height: 7),
                SizedBox(
                  height: 16,
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
                      const SizedBox(width: 3),
                      Text(
                        "${upcomingsItem.releaseMonth} ${upcomingsItem.releaseDate}, ${upcomingsItem.releaseYear}",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const VerticalDivider(
                        thickness: 1.3,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        'assets/images/icon_film.svg',
                        height: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        width: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        colorFilter: const ColorFilter.mode(
                          TextColors.greyText,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        upcomingsItem.genre,
                        style: const TextStyle(
                          fontFamily: "MM",
                          fontSize: 12,
                          color: TextColors.greyText,
                        ),
                      ),
                    ],
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: BlocProvider(
                        create: (context) => NewsBloc(locator.get())
                          ..add(
                            FetchNewsEvent(),
                          ),
                        child: const NewsScreen(),
                      ),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/images/news_icon.svg',
                    colorFilter: const ColorFilter.mode(
                      TextColors.greyText,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.upcomings,
                  style: TextStyle(
                    fontFamily: StringConstants.setBoldPersianFont(),
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(
                  height: 24,
                  width: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingLoading extends StatelessWidget {
  const UpcomingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: ShimmerSkelton(
                  height: 20,
                  width: 100,
                  radius: 10,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkelton(
                    height: 168,
                    width: MediaQueryHandler.screenWidth(context),
                    radius: 16,
                  ),
                  const SizedBox(height: 10),
                  const ShimmerSkelton(
                    height: 20,
                    width: 100,
                    radius: 5,
                  ),
                  const SizedBox(height: 10),
                  const ShimmerSkelton(
                    height: 20,
                    width: 250,
                    radius: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkelton(
                    height: 168,
                    width: MediaQueryHandler.screenWidth(context),
                    radius: 16,
                  ),
                  const SizedBox(height: 10),
                  const ShimmerSkelton(
                    height: 20,
                    width: 100,
                    radius: 5,
                  ),
                  const SizedBox(height: 10),
                  const ShimmerSkelton(
                    height: 20,
                    width: 200,
                    radius: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkelton(
                    height: 168,
                    width: MediaQueryHandler.screenWidth(context),
                    radius: 16,
                  ),
                  const SizedBox(height: 10),
                  const ShimmerSkelton(
                    height: 20,
                    width: 100,
                    radius: 5,
                  ),
                  const SizedBox(height: 10),
                  const ShimmerSkelton(
                    height: 20,
                    width: 200,
                    radius: 5,
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
