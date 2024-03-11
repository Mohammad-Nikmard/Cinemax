import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class GalleryFullScreen extends StatelessWidget {
  const GalleryFullScreen({super.key, required this.imageURL});
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: SizedBox(
        height: 300,
        width: 300,
        child: FittedBox(
          fit: BoxFit.cover,
          child: CachedImage(
            imageUrl: imageURL,
            radius: 15,
          ),
        ),
      ),
    );
  }
}
