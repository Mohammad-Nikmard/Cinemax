import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';

class UpcomingsScreen extends StatelessWidget {
  const UpcomingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomScrollView(
          slivers: [
            const _Header(),
            CategoryList(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: _UpcomingChip(),
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingChip extends StatelessWidget {
  const _UpcomingChip();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 224,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 168,
            decoration: const BoxDecoration(
              color: SecondaryColors.greenColor,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "The Batman",
                style: TextStyle(
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
                    Image.asset(
                      'assets/images/icon_calendar.png',
                      height: 16,
                      width: 16,
                      color: TextColors.greyText,
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      "March 2, 2022",
                      style: TextStyle(
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
                    Image.asset(
                      'assets/images/icon_film.png',
                      height: 16,
                      width: 16,
                      color: TextColors.greyText,
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      "Action",
                      style: TextStyle(
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const BackLabel(),
                ),
                const Text(
                  "Upcomings",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
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
    );
  }
}