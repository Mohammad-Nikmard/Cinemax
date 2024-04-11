import 'package:cinemax/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExceptionMessage extends StatelessWidget {
  const ExceptionMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.exception,
      style: TextStyle(
        fontFamily: StringConstants.setBoldPersianFont(),
        fontSize: 16,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
