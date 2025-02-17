import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Services/auth_service.dart';
import 'package:task_trader/Views/bottom_navigation_bar.dart';
import 'package:task_trader/Views/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> signupformKey = GlobalKey<FormState>();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final checkValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.appText(
                  "Getting Started",
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  textColor: AppTheme.white,
                ),
                SizedBox(
                  height: 20,
                ),
                AppText.appText("Create an account to continue!"),
                SizedBox(
                  height: 60,
                ),
                Form(
                    key: signupformKey,
                    child: Column(
                      children: [
                        CustomAppFormField(
                          texthint: "Full name",
                          controller: _fullName,
                          // validator: (value) =>
                          //     FormValidator.validateName(value),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomAppFormField(
                          texthint: "Email Address",
                          controller: _email,
                          // validator: (value) =>
                          //     FormValidator.validateEmail(value),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomAppPasswordfield(
                          controller: _password,
                          texthint: "Password",
                          // validator: (value) =>
                          //     FormValidator.validatePassword(value),
                        ),
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                AppButton.appButton(
                  onTap: () async {
                    if (_fullName.text.isEmpty ||
                        _email.text.isEmpty ||
                        _password.text.isEmpty) {
                      AuthService().showToast("Please fill all fields");
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(_email.text)) {
                      AuthService().showToast("Enter a valid email");
                    } else if (_password.text.length < 8) {
                      AuthService()
                          .showToast("Password must be at least 8 characters");
                    } else {
                      try {
                        await AuthService().signup(
                          name: _fullName.text.trim(),
                          email: _email.text.trim(),
                          password: _password.text.trim(),
                          context: context,
                        );
                      } catch (e) {
                        AuthService().showToast("Error: $e");
                      }
                    }
                  },
                  "Start",
                  radius: 28.0,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),

                // AppButton.appButton(onTap: () async {
                //   if (_fullName.text.isNotEmpty ||
                //       _email.text.isNotEmpty ||
                //       _password.text.isNotEmpty) {
                //     try {
                //       await AuthService().signup(
                //         name: _fullName.text.trim(),
                //         email: _email.text.trim(),
                //         password: _password.text.trim(),
                //         context: context,
                //       );
                //     } catch (e) {
                //       AuthService().showToast("Error: $e");
                //     }
                //   } else {
                //     AuthService().showToast("Please fill all fields");
                //   }
                // }, "Start",
                //     radius: 28.0, fontSize: 18, fontWeight: FontWeight.w400),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.appText("Already have an account ? "),
                    GestureDetector(
                        onTap: () {
                          pushReplacement(context, Login());
                        },
                        child: AppText.appText("Sign in",
                            textColor: AppTheme.appColor)),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
