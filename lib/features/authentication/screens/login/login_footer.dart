import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inizia2324/features/authentication/screens/signin/signin_screen.dart';
import 'package:inizia2324/utils/constants/sizes.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(TTexts.tOr),
        const SizedBox(height: TSizes.tFormHeight - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon:
                const Image(image: AssetImage(TImages.googleLogo), width: 20.0),
            onPressed: () {
              //TODO: SIGN-UP WITH GOOGLE
            },
            label: const Text(TTexts.tSignUpWithGoogle),
          ),
        ),
        const SizedBox(height: TSizes.tFormHeight - 20),
        TextButton(
          onPressed: () {
            Get.to(() => const SignUpScreen());
          },
          child: Text.rich(
            TextSpan(
                text: TTexts.tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                      text: TTexts.tSignup.toUpperCase(),
                      style: const TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}
