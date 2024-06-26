import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.text,
    required this.controller,
  });
  final String text;
  final TextEditingController controller;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: TextColors.greyText,
        fontFamily: StringConstants.setMediumPersionFont(),
        fontSize: 14,
      ),
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: TextStyle(
          color: TextColors.greyText,
          fontSize: 15,
          fontFamily: StringConstants.setMediumPersionFont(),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: TextColors.greyText,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(27),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: TextColors.greyText,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(27),
          ),
        ),
      ),
    );
  }
}
