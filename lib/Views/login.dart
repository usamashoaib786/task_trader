import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Services/auth_service.dart';
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
                          AppButton.appButton(onTap: () async {
                            
                            if (_email.text.isEmpty || _password.text.isEmpty) {
                              AuthService().showToast("Please fill all fields");
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(_email.text)) {
                              AuthService().showToast("Enter a valid email");
                            } else if (_password.text.length < 8) {
                              AuthService().showToast(
                                  "Invalid password: minimum 8 characters required.");
                            } else {
                              try {
                                showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // Prevent closing by tapping outside
                              builder: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            );
                            
                                await AuthService().signin(
                                    email: _email.text.trim(),
                                    password: _password.text.trim(),
                                    context: context);
                              } catch (e) {
                                if (!context.mounted) return;
                                Navigator.of(context).pop();
                                AuthService().showToast("Error: $e");
                              }
                            }
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
