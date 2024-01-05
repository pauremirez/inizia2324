import 'package:flutter/material.dart';

import '../../constants/color_strings.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: TColors.tSecondaryColor,
    floatingLabelStyle: TextStyle(color: TColors.tSecondaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: TColors.tSecondaryColor),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: TColors.tPrimaryColor,
    floatingLabelStyle: TextStyle(color: TColors.tPrimaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: TColors.tPrimaryColor),
    ),
  );
}
