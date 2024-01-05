// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/color_strings.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../login/loginScreen.dart';
import '../signin/signin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    //Change the backgroung to primar color when we change from dark mode to light mode

    return Scaffold(
      backgroundColor:
          isDarkMode ? TColors.tSecondaryColor : TColors.tPrimaryColor,
      body: Container(
        padding: const EdgeInsets.all(TSizes.tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
                image: isDarkMode
                    ? const AssetImage(TImages.tWelcomeScreenImageDark)
                    : const AssetImage(TImages.tWelcomeScreenImage),
                height: height * 0.6),
            Column(
              children: [
                Text(TTexts.tWelcomeTitle,
                    style: Theme.of(context).textTheme.displaySmall),
                Text(TTexts.tWelcomeSubTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: Text(TTexts.tLogin.toUpperCase()),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const SignUpScreen());
                    },
                    child: Text(TTexts.tSignup.toUpperCase()),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
