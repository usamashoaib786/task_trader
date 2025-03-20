import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/custom_dialogue.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Resources/utils.dart';
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
  String? _pickedFilePath;
  TextEditingController fullName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

  // pickImage() async {
  //   final ImagePicker picker = ImagePicker();

  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       _pickedFilePath = image.path;
  //       // updateProfile();
  //     });
  //   }
  // }

  void _fetchProfiles() async {
    Map<String, dynamic>? userProfile =
        await ProfileService().fetchUserProfile();

    if (userProfile != null && mounted) {
      setState(() {
        fullName.text = userProfile["name"] ?? "";
        phoneNumber.text = userProfile["number"] ?? "";
        emailAddress.text = userProfile["email"] ?? "";
        // _pickedFilePath = userProfile["imageUrl"];
      });
    } else {
      if (kDebugMode) {
        print("Profile not found! _fetchProfiles");
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
              SizedBox(
                  height: 140,
                  width: 140,
                  child: Stack(
                    children: [
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2, color: AppTheme.appColor),
                              borderRadius: BorderRadius.circular(100)),
                          child: Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                                color: AppTheme.appColor,
                                shape: BoxShape.circle),
                            child: _pickedFilePath != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: _pickedFilePath!.startsWith("http")
                                        ? Image.network(
                                            _pickedFilePath!,
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.file(
                                            File(_pickedFilePath!),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.fill,
                                          ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image.asset(
                                      Images.memojiBoysAvtar,
                                      height: 66,
                                      width: 66,
                                    ),
                                  ),
                          )),
                      // if (_isEditing)
                      //   GestureDetector(
                      //     onTap: () {
                      //        pickImage();
                      //     },
                      //     child: Align(
                      //       alignment: Alignment.bottomRight,
                      //       child: Card(
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(100)),
                      //         child: Container(
                      //           height: 40,
                      //           width: 40,
                      //           decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: AppTheme.white),
                      //           child: Icon(
                      //             Icons.camera,
                      //             color: AppTheme.appColor,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  )),
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

                                // String? imageUrl;
                                // if (_pickedFilePath != null) {
                                //   imageUrl = await ProfileService()
                                //       .uploadProfileImage(
                                //           File(_pickedFilePath!));
                                // }
                                if (!context.mounted) return;
                                await AuthService().updateUserInfo(
                                  name: fullName.text,
                                  //  email: emailAddress.text,
                                  // imageUrl: imageUrl,
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
}
