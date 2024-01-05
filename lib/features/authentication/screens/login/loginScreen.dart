// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';
import 'login_footer.dart';
import 'login_form.dart';
import 'login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.tDefaultSize),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* -- Section 1 -- */
                LoginHeaderWidget(),
                /* -- Section 2 -- */
                LoginForm(),
                /* -- Section 3 -- */
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
