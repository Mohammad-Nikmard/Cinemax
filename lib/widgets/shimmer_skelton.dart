import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ShimmerSkelton extends StatelessWidget {
  const ShimmerSkelton(
      {super.key,
      required this.height,
      required this.width,
      required this.radius});
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: SizedBox(
        height: height,
        width: width,
        child: ColoredBox(
          color: TextColors.wihteGreyText.withOpacity(0.2),
        ),
      ),
    );
  }
}
