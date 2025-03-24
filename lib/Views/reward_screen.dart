import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Views/progress_bar.dart';

class YourRewardStatus extends StatefulWidget {
  final bool allRulesSelected;

  const YourRewardStatus({super.key, required this.allRulesSelected});

  @override
  State<YourRewardStatus> createState() => _YourRewardStatusState();
}

class _YourRewardStatusState extends State<YourRewardStatus> {
int currentLevel = 3;
  
  bool isBronzeChecked = false;
  bool isSilverChecked = false;
  bool isGoldChecked = false;
  bool isPlatinumChecked = false;

@override
  void initState() {
    super.initState();
    
    
    if (widget.allRulesSelected != false) {
      currentLevel = (currentLevel - 1).clamp(0, 5);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingIcon: Images.backIconBlack,
        title: "Your Reward Status",
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
              AppText.appText(widget.allRulesSelected ? "Trade Sucessfull" : "Trade Unscessfull",
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
                        text: 'Bronze',
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
                currentLevel: currentLevel, // Set current level (e.g., 3 out of 5)
                totalLevels: 5, // Total levels
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
                      onChanged: (bool? value) {
                        setState(() {
                          isBronzeChecked = value!;
                        });
                      },
                    ),
                    checkBoxListTile(
                      isChecked: isSilverChecked,
                      title: "6-15 Silver",
                      onChanged: (bool? value) {
                        setState(() {
                          isSilverChecked = value!;
                        });
                      },
                    ),
                    checkBoxListTile(
                      isChecked: isGoldChecked,
                      title: "16-30 Gold",
                      onChanged: (bool? value) {
                        setState(() {
                          isGoldChecked = value!;
                        });
                      },
                    ),
                    checkBoxListTile(
                      isChecked: isPlatinumChecked,
                      title: "31+ Platinum",
                      onChanged: (bool? value) {
                        setState(() {
                          isPlatinumChecked = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              AppText.appText("Tier Downgrade Alert:",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.red),
              SizedBox(
                height: 10,
              ),
              AppText.appText(
                  "Tier Update: It looks like you've temporarily moved down a tier due to an incomplete task. Stay focused – with a little extra effort, you can earn back your Gold tier!",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: Colors.red),
              SizedBox(
                height: 40,
              ),
              AppButton.appButton("Claim Reward",
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
        ),
      ),
    );
  }
}

// ListTile Widget with Checkbox
Widget checkBoxListTile({
  required String title,
  required bool isChecked,
  required ValueChanged<bool?> onChanged,
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
        onChanged: onChanged,
      ),
    ),
    title: AppText.appText(title),
  );
}
