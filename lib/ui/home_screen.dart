import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/banner.dart';
import 'package:cinemax/widgets/movie_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const CustomScrollView(
        slivers: [
          _HomeHeader(name: "Mohammad"),
          SearchBox(),
          SliverToBoxAdapter(
            child: BannerContainer(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 20),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontFamily: "MM",
                  fontSize: 16,
                  color: TextColors.whiteText,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          CategoryList(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                "Most Popular",
                style: TextStyle(
                  fontFamily: "MM",
                  fontSize: 16,
                  color: TextColors.whiteText,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          MostPopList(),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: PrimaryColors.blueAccentColor,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, $name",
                      style: TextStyle(
                        fontFamily: "MSB",
                        fontSize: (screenSize.width < 350) ? 12 : 16,
                        color: TextColors.whiteText,
                      ),
                    ),
                    Text(
                      "Let's find a movie for you",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (screenSize.width < 350) ? 8 : 12,
                        color: TextColors.greyText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 32,
              width: 32,
              decoration: const ShapeDecoration(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                color: PrimaryColors.softColor,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/icon_heart.png',
                  color: SecondaryColors.redColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: Container(
          height: 41,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: PrimaryColors.softColor,
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/icon_search.png',
                      color: TextColors.greyText,
                      height: 16,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Search a title...",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: 14,
                        color: TextColors.greyText,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: VerticalDivider(
                        color: TextColors.greyText,
                        thickness: 1.3,
                      ),
                    ),
                    Image.asset(
                      'assets/images/icon_setters.png',
                      height: 16,
                      width: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
      padding: const EdgeInsets.only(left: 20, top: 20),
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

class MostPopList extends StatelessWidget {
  const MostPopList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20),
        child: SizedBox(
          height: 231,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(right: 15),
                child: MovieWidget(),
              );
            },
          ),
        ),
      ),
    );
  }
}