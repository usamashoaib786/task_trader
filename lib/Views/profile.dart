import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/custom_dialogue.dart';
import 'package:task_trader/Resources/pref_keys.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Services/auth_service.dart';
import 'package:task_trader/Services/profile_service.dart';
import 'package:task_trader/Views/Auth%20Screens/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Map<String, dynamic>> profiles = [];
  bool _isEditing = false;
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String? userName;
  String? userEmail;
  String? userPhone;

  @override
  void initState() {
    super.initState();
    // _fetchProfiles();
    getUserDetail();
  }

  getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(PrefKey.userName);
    userEmail = prefs.getString(PrefKey.email);
    userPhone = prefs.getString(PrefKey.phone);

    setState(() {
      fullName.text = userName ?? "";
      phoneNumber.text = userPhone ?? "";
      emailAddress.text = userEmail ?? "";
    });
  }


  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: "Profile",
        fontsize: 25,
        fontWeight: FontWeight.w800,
        color: AppTheme.white,
        actions: [
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(
                    child: CustomDialog(
                  title: "Are you sure you want to log out?",
                  onNoTap: () {
                    Navigator.pop(context);
                  },
                  onYesTap: () async {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // Prevent closing by tapping outside
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                    );

                    await AuthService().signOutUser();

                    Future.delayed(const Duration(seconds: 1), () {
                      if (!context.mounted) return;
                      Navigator.of(context).pop();

                      pushUntil(context, Login());
                    });
                  },
                )),
              );
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: AppTheme.appColor, shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  Icons.logout,
                  color: AppTheme.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              customColumn(
                txt: "Name",
                controller: fullName,
                enabled: _isEditing,
              ),
              SizedBox(height: 20),
              customColumn(
                  txt: "Email",
                  controller: emailAddress,
                  enabled: false),
              SizedBox(height: 20),
              customColumn(
                txt: "Password",
                controller: password,
                txtHint: "********",
                enabled: false,
              ),
              SizedBox(height: 20),
              customColumn(
                txt: "Phone Number",
                txtHint: "+00 0000 0000 000",
                controller: phoneNumber,
                enabled: _isEditing,
              ),
              SizedBox(height: 40),
              AppButton.appButton(
                !_isEditing ? "Edit Profile" : "Save",
                width: ScreenSize(context).width,
                height: 62,
                radius: 28.0,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                onTap: !_isEditing
                    ? _toggleEdit
                    : () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Center(
                              child: CustomDialog(
                            title: "Do You want to save all changes?",
                            onNoTap: () {
                              _toggleEdit();

                              Navigator.pop(context);
                            },
                            onYesTap: () async {
                              try {
                                showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // Prevent closing by tapping outside
                                  builder: (context) => Center(
                                      child: CircularProgressIndicator()),
                                );
                                if (!context.mounted) return;
                                await AuthService().updateUserInfo(
                                  name: fullName.text,
                                  //  email: emailAddress.text,
                                  number: phoneNumber.text,
                                  context: context,
                                );
                                if (!context.mounted) return;
                                Navigator.of(context).pop();

                                _toggleEdit();
                                setState(() {
                                  _isEditing = false;
                                });
                              } catch (e) {
                                Navigator.of(context).pop();
                                AuthService().showToast("Error: $e");
                              }

                              Navigator.of(context).pop();
                            },
                          )),
                        );
                      },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget customColumn({txt, txtHint, controller, enabled}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.appText("$txt",
              textColor: AppTheme.offWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w800),
          SizedBox(
            height: 10,
          ),
          CustomAppFormField(
            texthint: "$txtHint",
            controller: controller,
            enabled: enabled,
          ),
        ],
      ),
    );
  }
}
