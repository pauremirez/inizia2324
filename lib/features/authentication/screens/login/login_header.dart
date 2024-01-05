import 'package:flutter/material.dart';
import 'package:inizia2324/utils/constants/image_strings.dart';
import 'package:inizia2324/utils/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: const AssetImage(TImages.logo), height: size.height * 0.2),
        Text(TTexts.tLoginTtitle,
            style: Theme.of(context).textTheme.displayLarge),
        Text(TTexts.tLoginSubTitle,
            style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
