import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../login/loginScreen.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(TTexts.tOr),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(TImages.googleLogo),
              width: 20.0,
            ),
            label: const Text(TTexts.tSignUpWithGoogle),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(() => const LoginScreen());
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: TTexts.tAlreadyHaveAnAccount,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextSpan(text: TTexts.tLogin.toUpperCase())
          ])),
        )
      ],
    );
  }
}
