import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Views/bottom_navigation_bar.dart';
import 'package:task_trader/Views/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: ScreenSize(context).height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 1,
                    ),
                    SizedBox(
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.appText(
                            "Let’s Sign You In",
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            textColor: AppTheme.white,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppText.appText(
                            "Welcome back, you’ve been missed!",
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            textColor: AppTheme.lightWhite,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Form(
                              child: Column(
                            children: [
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        children: [
                          AppButton.appButton(onTap: () {
                            pushReplacement(context, BottomNavView(showPopup: true,));
                          }, "Login",
                              radius: 28.0,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText.appText("Dont’s have an account? "),
                              GestureDetector(
                                  onTap: () {
                                    push(context, Signup());
                                  },
                                  child: AppText.appText("Sign up",
                                      textColor: AppTheme.appColor)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
