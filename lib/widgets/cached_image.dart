import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.imageUrl, required this.radius});
  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) {
          return Container(
            color: Colors.white,
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            color: SecondaryColors.redColor,
          );
        },
      ),
    );
  }
}
