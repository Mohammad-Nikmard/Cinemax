import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';

class SnackbarContent extends StatelessWidget {
  const SnackbarContent(
      {super.key, required this.message, required this.color});
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          AppManager.getLnag() == 'fa' ? TextDirection.rtl : TextDirection.ltr,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        child: ColoredBox(
          color: color,
          child: SizedBox(
            width: MediaQueryHandler.screenWidth(context),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    color: TextColors.whiteText,
                    fontSize: 12,
                    fontFamily: StringConstants.setMediumPersionFont(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
