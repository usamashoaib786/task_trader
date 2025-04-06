import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/pref_keys.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Services/auth_service.dart';
import 'package:task_trader/Views/ai_screen.dart';
import 'package:task_trader/Views/bottom_navigation_bar.dart';
import 'package:task_trader/Views/progress_bar.dart';

class YourRewardStatus extends StatefulWidget {
  final bool? allRulesSelected;
  final bool? isHomeScreen;
  const YourRewardStatus({super.key, this.allRulesSelected, this.isHomeScreen});

  @override
  State<YourRewardStatus> createState() => _YourRewardStatusState();
}

class _YourRewardStatusState extends State<YourRewardStatus> {
  int currentLevel = 3;

  bool isBronzeChecked = false;
  bool isSilverChecked = false;
  bool isGoldChecked = false;
  bool isPlatinumChecked = false;
  String? userPoints;
  String? userLevel;

  @override
  void initState() {
    super.initState();
    check();
    if (widget.isHomeScreen == true) {
      getData();
    }
    if (widget.allRulesSelected != false) {
      currentLevel = (currentLevel - 1).clamp(0, 5);
    }
  }

  check() {
    if (widget.allRulesSelected == true) {
      tierUpgrdade();
    } else {
      tierDownGrade();
    }
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userLevel = pref.getString(PrefKey.userLevel);
      userPoints = pref.getString(PrefKey.userPoints);
      setCheckedLevel(userLevel!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pushUntil(context, BottomNavView());
        return false; // Prevent default back action
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomAppBar(
          leadingIcon: Images.backIconBlack,
          title: "Your Reward Status",
          rewardPage: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                AppText.appText(
                    widget.allRulesSelected == true
                        ? "Trade Sucessfull"
                        : "Trade Unscessfull",
                    textColor: AppTheme.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Current Reward Tier:  ',
                    style: TextStyle(color: AppTheme.white, fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                          text: '$userLevel',
                          style: TextStyle(
                              color: AppTheme.appColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TierProgressBar(
                  userPoints: userPoints == null ? 0 : int.parse(userPoints!),
                  totalLevels:
                      userLevel == null ? 5 : getTotalLevelsForTier(userLevel!),
                  userLevel: userLevel ?? "",
                ),
                SizedBox(
                  height: 20,
                ),
                AppText.appText("Milestone",
                    textColor: AppTheme.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF211E41),
                  ),
                  width: 320,
                  height: 285,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      checkBoxListTile(
                        isChecked: isBronzeChecked,
                        title: "0-5 Bronze",
                      ),
                      checkBoxListTile(
                        isChecked: isSilverChecked,
                        title: "6-15 Silver",
                      ),
                      checkBoxListTile(
                        isChecked: isGoldChecked,
                        title: "16-30 Gold",
                      ),
                      checkBoxListTile(
                        isChecked: isPlatinumChecked,
                        title: "31+ Platinum",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                if (widget.isHomeScreen != true)
                  AppText.appText(
                      widget.allRulesSelected == true
                          ? "Tier Upgrade Alert:"
                          : "Tier Downgrade Alert:",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      textColor: widget.allRulesSelected == true
                          ? Colors.greenAccent
                          : Colors.red),
                SizedBox(
                  height: 10,
                ),
                if (widget.isHomeScreen != true)
                  AppText.appText(
                      widget.allRulesSelected == true
                          ? "Tier Update: Congratulations! You've successfully leveled up due to your hard work and consistency. Keep pushing forward and aim for the next milestone!"
                          : "Tier Update: It looks like you've temporarily moved down a tier due to an incomplete task. Stay focused with a little extra effort, you can earn back your tier!",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: widget.allRulesSelected == true
                          ? Colors.white
                          : Colors.red),
                SizedBox(
                  height: 40,
                ),
                if (widget.allRulesSelected != true)
                  AppButton.appButton("Get Assistance",
                      width: ScreenSize(context).width, onTap: () {
                    push(context, AiPowered());
                  },
                      height: 62,
                      radius: 28.0,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getTotalLevelsForTier(String level) {
    switch (level) {
      case "Bronze":
        return 5;
      case "Silver":
        return 15;
      case "Gold":
        return 30;
      case "Platinum":
        return 50;
      default:
        return 5; // Default to Bronze if no valid level
    }
  }

  String getUserLevel(int points) {
    if (points >= 31) {
      return "Platinum";
    } else if (points >= 16) {
      return "Gold";
    } else if (points >= 6) {
      return "Silver";
    } else {
      return "Bronze";
    }
  }

  void tierUpgrdade() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) return; // Exit if no user is logged in

    DocumentReference docRef = firestore.collection("users").doc(user.uid);

    setState(() {
      var points = prefs.getString(PrefKey.userPoints) ?? "0";
      int updatedPoints = int.parse(points) + 1; // Increase points

      // Get previous level
      userLevel = prefs.getString(PrefKey.userLevel) ?? "Bronze";
      // Determine new level
      setCheckedLevel(userLevel!);
      String newLevel = getUserLevel(updatedPoints);
      // Save points locally
      prefs.setString(PrefKey.userPoints, updatedPoints.toString());
      userPoints = updatedPoints.toString();

      // If level changes, update in Firebase
      if (newLevel != userLevel) {
        prefs.setString(PrefKey.userLevel, newLevel);
        userLevel = newLevel;
        setCheckedLevel(userLevel!);

        // Update in Firebase
        docRef.update({
          'profile.points': updatedPoints.toString(),
          'profile.level': newLevel,
        }).then((_) {
          AuthService().showToast("User level updated to $newLevel");
        }).catchError((error) {
          AuthService().showToast("Error updating user level: $error");
        });
      } else {
        // Only update points if level remains same
        docRef.update({
          'profile.points': updatedPoints.toString(),
        });
      }
    });
  }

  void setCheckedLevel(String level) {
    setState(() {
      isBronzeChecked = level == "Bronze";
      isSilverChecked = level == "Silver";
      isGoldChecked = level == "Gold";
      isPlatinumChecked = level == "Platinum";
    });
  }

  void tierDownGrade() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    DocumentReference docRef = firestore.collection("users").doc(user.uid);

    setState(() {
      var points = prefs.getString(PrefKey.userPoints) ?? "0";
      int updatedPoints =
          (int.parse(points) - 1).clamp(0, 999999); // Prevent negative points

      // Get previous level
      userLevel = prefs.getString(PrefKey.userLevel) ?? "Bronze";
      // Determine new level
      String newLevel = getUserLevel(updatedPoints);
      setCheckedLevel(userLevel!);

      // Save points locally
      prefs.setString(PrefKey.userPoints, updatedPoints.toString());
      userPoints = updatedPoints.toString();

      // If level changes, update in Firebase
      if (newLevel != userLevel) {
        prefs.setString(PrefKey.userLevel, newLevel);
        userLevel = newLevel;
        setCheckedLevel(userLevel!);

        // Update in Firebase
        docRef.update({
          'profile.points': updatedPoints.toString(),
          'profile.level': newLevel,
        }).then((_) {
          AuthService().showToast("User level updated to $newLevel");
        }).catchError((error) {
          AuthService().showToast("Error updating user level: $error");
        });
      } else {
        // Only update points if level remains same
        docRef.update({
          'profile.points': updatedPoints.toString(),
        });
      }
    });
  }
}

// ListTile Widget with Checkbox
Widget checkBoxListTile({
  required String title,
  required bool isChecked,
}) {
  return ListTile(
    leading: Transform.scale(
      scale: 2,
      child: Checkbox(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xFF077F89);
          }
          return const Color(0xFF077F89).withAlpha(150);
        }),
        activeColor: const Color(0xFF077F89),
        side: BorderSide(color: const Color(0xFF077F89).withAlpha(150)),
        value: isChecked,
        onChanged: null,
      ),
    ),
    title: AppText.appText(title),
  );
}
