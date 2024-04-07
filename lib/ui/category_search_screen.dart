import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/related_search_widget.dart';
import 'package:flutter/material.dart';

class CategorySearchScreen extends StatelessWidget {
  const CategorySearchScreen(
      {super.key, required this.title, required this.movieList});
  final String title;
  final List<Movie> movieList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Directionality(
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
                              fontFamily: StringConstants.setBoldPersianFont(),
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 350)
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
                            movie: movieList[index],
                          ),
                        );
                      },
                      childCount: movieList.length,
                    ),
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
