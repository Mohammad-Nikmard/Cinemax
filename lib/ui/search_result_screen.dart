import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/related_search_widget.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: PrimaryColors.softColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/icon_search.png',
                                height: 16,
                                width: 16,
                                color: TextColors.greyText,
                              ),
                              const SizedBox(width: 10.0),
                              const Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    fontFamily: "MM",
                                    fontSize: 14,
                                    color: TextColors.whiteText,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                    border: InputBorder.none,
                                    hintText: "Type Something...",
                                    hintStyle: TextStyle(
                                      fontFamily: "MM",
                                      fontSize: 14,
                                      color: TextColors.greyText,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: "MM",
                            fontSize: 12,
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: RelatedActorList(),
            ),
            const SliverToBoxAdapter(
              child: MovieRelatedHeader(),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return const Padding(
            //         padding: EdgeInsets.only(bottom: 20),
            //         child: RelatedSeachWidget(),
            //       );
            //     },
            //     childCount: 10,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class MovieRelatedHeader extends StatelessWidget {
  const MovieRelatedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Movie Related",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 16,
                  color: TextColors.whiteText,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  fontFamily: "MM",
                  fontSize: 14,
                  color: PrimaryColors.blueAccentColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class RelatedActorList extends StatelessWidget {
  const RelatedActorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Actors",
          style: TextStyle(
            fontFamily: "MSB",
            fontSize: 16,
            color: TextColors.whiteText,
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 110,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, inde) {
              return const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: RelatedActor(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RelatedActor extends StatelessWidget {
  const RelatedActor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: PrimaryColors.blueAccentColor,
        ),
        SizedBox(height: 10),
        Text(
          "John Cena",
          style: TextStyle(
            fontFamily: "MSB",
            fontSize: 12,
            color: TextColors.whiteText,
          ),
        ),
      ],
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          children: [
            Image.asset('assets/images/search_image.png'),
            const SizedBox(height: 10),
            const SizedBox(
              width: 200,
              child: Text(
                "We Are Sorry, We Can Not Find The Movie :(",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 16,
                  color: TextColors.whiteText,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 210,
              child: Text(
                "Find your movie by Type title, Categories, Years, etc",
                style: TextStyle(
                  fontFamily: "MM",
                  fontSize: 12,
                  color: TextColors.greyText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
