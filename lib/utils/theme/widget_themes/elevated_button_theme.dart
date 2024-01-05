import 'package:flutter/material.dart';

import '../../constants/color_strings.dart';
import '../../constants/sizes.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      backgroundColor: TColors.tSecondaryColor,
      foregroundColor: TColors.tPrimaryColor,
      side: const BorderSide(color: TColors.tSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: TSizes.tButtonHeight),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      backgroundColor: TColors.tWhiteColor,
      foregroundColor: TColors.tSecondaryColor,
      side: const BorderSide(color: TColors.tWhiteColor),
      padding: const EdgeInsets.symmetric(vertical: TSizes.tButtonHeight),
    ),
  );
}
