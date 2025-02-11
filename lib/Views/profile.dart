import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/screen_sizes.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: "Profile",
        fontsize: 20,
        fontWeight: FontWeight.w600,
        color: AppTheme.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              CircleAvatar(
                backgroundColor: Color(0XFFFFD9AF),
                radius: 58,
                backgroundImage: AssetImage(Images.memojiBoysAvtar),
                child: Stack(children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 18,
                      child: Icon(Icons.camera),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 40,
              ),
              CustomAppFormField(
                texthint: "Full Name",
                controller: fullName,
              ),
              SizedBox(
                height: 20,
              ),
              CustomAppFormField(
                texthint: "Email Address",
                controller: emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              CustomAppPasswordfield(
                controller: password,
                texthint: "********",
              ),
              SizedBox(
                height: 20,
              ),
              CustomAppFormField(
                texthint: "+00 0000 0000 000",
                controller: phoneNumber,
              ),
              SizedBox(
                height: 40,
              ),
              AppButton.appButton("Save",
                  width: ScreenSize(context).width,
                  height: 62,
                  radius: 28.0,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
