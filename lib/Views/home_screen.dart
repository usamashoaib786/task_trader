import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trader/Resources/app_bar_home.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/pref_keys.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Views/progress_bar.dart';
import 'package:task_trader/Views/reward_screen.dart';
import 'package:task_trader/Views/rules.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  String? userPoints;
  String? userLevel;

  @override
  initState() {
    super.initState();
    getUserDetail();
  }

  getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString(PrefKey.userName);
      userPoints = prefs.getString(PrefKey.userPoints);
      userLevel = prefs.getString(PrefKey.userLevel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarHome(
        userDisplayName: userName ?? "Is Loading...",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: 'Tier Level :   ',
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
                totalLevels: userLevel == null
                    ? 5
                    : getTotalLevelsForTier(userLevel!), // Total levels
                userLevel: userLevel ?? "",
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 50,
                width: ScreenSize(context).width,
                decoration: BoxDecoration(
                    color: AppTheme.offWhiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: AppText.appText("Check each rule below",
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      textColor: AppTheme.appColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      width: ScreenSize(context).width,
                      height: 400,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 132, 124, 134),
                            AppTheme.appColor
                          ]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Rules()),
                ),
              )
            ],
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
}

//Alert Dialogue Widget used in HomePage
class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppText.appText(
                "Did you follow all of your rules?",
                fontSize: 26,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                textColor: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: AppButton.appButtonwithspecificRadius("YES",
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(12)),
                        backgroundColor: AppTheme.appColor,
                        borderColor: AppTheme.appColor, onTap: () {
                      push(context, YourRewardStatus(allRulesSelected: true));
                    }),
                  ),
                  Expanded(
                    child: AppButton.appButtonwithspecificRadius("NO",
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(12)),
                        textColor: AppTheme.appColor,
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.transparent, onTap: () {
                      push(context, YourRewardStatus(allRulesSelected: false));
                    }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showPopupDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.topCenter,
        child: Dialog(
          backgroundColor: Colors.black,
          child: Container(
            height: ScreenSize(context).height * 0.7,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Images.bronzeBadge,
                AppButton.appButton("START", onTap: () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ),
      );
    },
  );
}
