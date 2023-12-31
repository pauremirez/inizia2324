import 'package:flutter/material.dart';
import 'package:inizia2324/utils/constants/text_strings.dart';

import '../../../../utils/constants/sizes.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: TSizes.tFormHeight - 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text(TTexts.tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: TSizes.tFormHeight - 20),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text(TTexts.tEmail),
                  prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: TSizes.tFormHeight - 20),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text(TTexts.tPhoneNumber),
                  prefixIcon: Icon(Icons.phone)),
            ),
            const SizedBox(height: TSizes.tFormHeight - 20),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text(TTexts.tPassword), prefixIcon: Icon(Icons.lock)),
            ),
            const SizedBox(height: TSizes.tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //TODO: sign-up
                },
                child: Text(TTexts.tSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
