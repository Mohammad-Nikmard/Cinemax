import 'package:cinemax/bloc/home/categoryDetail/category_detail_bloc.dart';
import 'package:cinemax/bloc/home/categoryDetail/category_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/related_search_widget.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class CategoryDetialScreen extends StatelessWidget {
  const CategoryDetialScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<CategoryDetailBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoadingState) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[100]!,
                  child: const CategoryDetailLoading(),
                );
              }
              if (state is CategoryResponseState) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const BackLabel(),
                                ),
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontFamily: "MSB",
                                    fontSize: (MediaQueryHandler.screenWidth(
                                                context) <
                                            350)
                                        ? 12
                                        : 16,
                                    color: TextColors.whiteText,
                                  ),
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 40),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: RelatedSeachWidget(
                                  movie: state.getMovies[index],
                                ),
                              );
                            },
                            childCount: state.getMovies.length,
                          ),
                        ),
                      ),
                    ],
                  ),
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

class CategoryDetailLoading extends StatelessWidget {
  const CategoryDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
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
          SizedBox(height: 35),
          Row(
            children: [
              ShimmerSkelton(
                height: 147,
                width: 112,
                radius: 15,
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkelton(
                    height: 20,
                    width: 160,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 80,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 210,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 150,
                    radius: 5,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              ShimmerSkelton(
                height: 147,
                width: 112,
                radius: 15,
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkelton(
                    height: 20,
                    width: 160,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 80,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 210,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 150,
                    radius: 5,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              ShimmerSkelton(
                height: 147,
                width: 112,
                radius: 15,
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkelton(
                    height: 20,
                    width: 160,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 80,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 210,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 150,
                    radius: 5,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              ShimmerSkelton(
                height: 147,
                width: 112,
                radius: 15,
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkelton(
                    height: 20,
                    width: 160,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 80,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 210,
                    radius: 5,
                  ),
                  SizedBox(height: 10),
                  ShimmerSkelton(
                    height: 20,
                    width: 150,
                    radius: 5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
