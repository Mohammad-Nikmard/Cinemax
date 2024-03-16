import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_bloc.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_event.dart';
import 'package:cinemax/bloc/upcomings/upcomings_bloc.dart';
import 'package:cinemax/bloc/upcomings/upcomings_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/upcomings.dart';
import 'package:cinemax/ui/upcoming_movie_detail.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingsScreen extends StatelessWidget {
  const UpcomingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<UpcomingsBloc, UpcomingsState>(
        builder: (context, state) {
          if (state is UpcomingsLoadingState) {
            return const AppLoadingIndicator();
          } else if (state is UpcomingsResponseState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
          screen: BlocProvider(
            create: (context) {
              var bloc = UpDetailBloc(locator.get());
              bloc.add(UpDetailDataRequestEvent(upcomingsItem.id));
              return bloc;
            },
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
                  style: const TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
                    color: TextColors.whiteText,
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
                        style: const TextStyle(
                          fontFamily: "MM",
                          fontSize: 12,
                          color: TextColors.whiteText,
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

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 20, bottom: 20.0),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 33,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    height: 31,
                    decoration: ShapeDecoration(
                      color: (selectedIndex == index)
                          ? PrimaryColors.softColor
                          : Colors.transparent,
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "All",
                          style: TextStyle(
                            fontFamily: "MM",
                            fontSize: 12,
                            color: (selectedIndex == index)
                                ? PrimaryColors.blueAccentColor
                                : TextColors.whiteText,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.upcomings,
                  style: const TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
                    color: TextColors.whiteText,
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
