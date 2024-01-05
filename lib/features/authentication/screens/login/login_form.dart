import 'package:flutter/material.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: TSizes.tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: TTexts.tEmail,
                  hintText: TTexts.tEmail,
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: TSizes.tFormHeight - 20),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: TTexts.tPassword,
                hintText: TTexts.tPassword,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null, //TODO: OCULTAR LA CONTRASEÑA
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
            ),
            const SizedBox(height: TSizes.tFormHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    // TODO: FORGET PASSWORD
                  },
                  child: const Text(TTexts.tForgetPassword)),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: LOGIN
                },
                child: Text(TTexts.tLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
