import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackLabel extends StatelessWidget {
  const BackLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: ShapeDecoration(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/images/icon_arrow_back.svg',
        ),
      ),
    );
  }
}
