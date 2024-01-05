import 'package:flutter/material.dart';

import '../../constants/color_strings.dart';
import '../../constants/sizes.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: TColors.tSecondaryColor,
      side: const BorderSide(color: TColors.tSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: TSizes.tButtonHeight),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: TColors.tWhiteColor,
      side: const BorderSide(color: TColors.tWhiteColor),
      padding: const EdgeInsets.symmetric(vertical: TSizes.tButtonHeight),
    ),
  );
}
