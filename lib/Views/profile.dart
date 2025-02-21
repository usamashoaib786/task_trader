import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Services/auth_service.dart';
import 'package:task_trader/Services/profile_service.dart';
import 'package:task_trader/Views/login.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

  void _fetchProfiles() async {
    Map<String, dynamic>? userProfile =
        await ProfileService().fetchUserProfile();

    if (userProfile != null && mounted) {
      setState(() {
        fullName.text = userProfile["name"] ?? "";
        phoneNumber.text = userProfile["number"] ?? "";
        emailAddress.text = userProfile["email"] ?? "";
      });
    } else {
      if (kDebugMode) {
        print("Profile not found!");
      }
    }
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
        fontsize: 20,
        fontWeight: FontWeight.w600,
        color: AppTheme.white,
        actions: [
          GestureDetector(
            onTap: _toggleEdit,
            child: Row(
              children: [
                Icon(
                  _isEditing ? Icons.cancel : Icons.edit,
                  color: AppTheme.appColor,
                ),
                SizedBox(width: 5),
                Text(
                  _isEditing ? "Cancel" : "Edit Profile",
                  style: TextStyle(color: AppTheme.appColor, fontSize: 16),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
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
              SizedBox(height: 40),
              CustomAppFormField(
                texthint: "Full Name",
                controller: fullName,
                enabled: _isEditing,
              ),
              SizedBox(height: 20),
              CustomAppFormField(
                texthint: "Email Address",
                controller: emailAddress,
                enabled: _isEditing,
              ),
              SizedBox(height: 20),
              CustomAppPasswordfield(
                controller: password,
                texthint: "********",
                enabled: _isEditing,
              ),
              SizedBox(height: 20),
              CustomAppFormField(
                texthint: "+00 0000 0000 000",
                controller: phoneNumber,
                enabled: _isEditing,
              ),
              SizedBox(height: 40),
              if (_isEditing)
                AppButton.appButton(
                  "Save",
                  width: ScreenSize(context).width,
                  height: 62,
                  radius: 28.0,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  onTap: () async {
                    try {
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Prevent closing by tapping outside
                        builder: (context) =>
                            Center(child: CircularProgressIndicator()),
                      );

                      await AuthService().updateUserInfo(
                        name: fullName.text,
                        //  email: emailAddress.text,
                        number: phoneNumber.text,
                        context: context,
                      );
                      Navigator.of(context).pop();
                      setState(() {
                        _isEditing = false;
                      });

                      AuthService().showToast("Profile updated successfully!");
                    } catch (e) {
                      AuthService().showToast("Error: $e");
                    }
                  },
                ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // Prevent closing by tapping outside
                    builder: (context) =>
                        Center(child: CircularProgressIndicator()),
                  );

                  await AuthService().signOutUser();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppTheme.appColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Logout",
                      style: TextStyle(color: AppTheme.appColor, fontSize: 16),
                    ),
                    SizedBox(width: 15),
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
