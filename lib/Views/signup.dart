import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Views/bottom_navigation_bar.dart';
import 'package:task_trader/Views/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                    child: Column(
                  children: [
                    CustomAppFormField(
                      texthint: "Full name",
                      controller: _fullName,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomAppFormField(
                      texthint: "Email Address",
                      controller: _email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomAppPasswordfield(
                      controller: _password,
                      texthint: "Password",
                    ),
                  ],
                )),
              ],
            ),
            Column(
              children: [
                AppButton.appButton(onTap: () {
                  push(context, BottomNavView(showPopup: true,));
                }, "Start",
                    radius: 28.0, fontSize: 18, fontWeight: FontWeight.w400),
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
