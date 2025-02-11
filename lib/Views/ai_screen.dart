import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/screen_sizes.dart';

class AiPowered extends StatefulWidget {
  const AiPowered({super.key});

  @override
  State<AiPowered> createState() => _AiPoweredState();
}

class _AiPoweredState extends State<AiPowered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingIcon: Images.backIconBlack,
        title: "AI Powered Voice Coaching",
        fontsize: 20,
        fontWeight: FontWeight.w600,
        color: AppTheme.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              AppText.appText("AI Coach:",
                  textColor: AppTheme.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: 10,
              ),
              AppText.appText("Stay Disciplined!",
                  textColor: AppTheme.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
              Spacer(),
              Images.aiPoweredImage,
              Spacer(),
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    AppButton.appButton("Play Audio",
                        width: ScreenSize(context).width,
                        height: 62,
                        radius: 28.0,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 20,
                    ),
                    AppButton.appButton("Continue",
                        width: ScreenSize(context).width,
                        height: 62,
                        radius: 28.0,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
