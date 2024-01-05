import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    this.imageHeight = 0.2,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  //Variables -- Declared in Constructor
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(crossAxisAlignment: crossAxisAlignment, children: [
      Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Image(
                image: AssetImage(image),
                color: imageColor,
                height: size.height * imageHeight),
            SizedBox(height: heightBetween),
            Text(title, style: Theme.of(context).textTheme.displayLarge),
            Text(subTitle,
                textAlign: textAlign,
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      )
    ]);
  }
}
