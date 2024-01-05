// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../controllers/splashscreen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    SplashScreenController.find.startAnimation();
    return Scaffold(
        body: Stack(children: [
      Obx(() => AnimatedPositioned(
          duration: const Duration(milliseconds: 1600),
          top: splashController.animate.value ? 30 : -30,
          left: splashController.animate.value ? 70 : -100,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1600),
            opacity: splashController.animate.value ? 1 : 0,
            child: const Image(image: AssetImage(TImages.logo)),
          ))),
      Obx(() => AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          top: splashController.animate.value ? 0 : -30,
          left: splashController.animate.value ? -200 : -100,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1600),
            opacity: splashController.animate.value ? 1 : 0,
            child: const Image(image: AssetImage(TImages.splashScreenImage)),
          ))),
    ]));
  }
}
