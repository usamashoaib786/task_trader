import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar_home.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Views/ai_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showPopupDialog(context);
    // });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: const AppBarHome(),
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
                  currentLevel: 3, // Set current level (e.g., 3 out of 5)
                  totalLevels: 5, // Total levels
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
      ),
    );
  }
}

class TradingRules extends StatefulWidget {
  const TradingRules({super.key});

  @override
  State<TradingRules> createState() => _TradingRulesState();
}

class _TradingRulesState extends State<TradingRules> {
  final List<String> rules = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac erat ut purus tristique feugiat nec accumsan ipsum.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac erat ut purus tristique feugiat nec accumsan ipsum. Nunc rhoncus, quam sed maximus pellentesque, diam orci consequat nisl, nec facilisis ante purus rhoncus ligula.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  ];

  // Use a set to store selected indices
  final Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText.appText("Current Running Trading Rules",
            textColor: AppTheme.whiteColor, fontSize: 20),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF211E41),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: rules.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? const Color(0xFFECECEC)
                            : const Color(0xFFFCDDEC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        title: AppText.appText(
                          rules[index],
                        ),
                        trailing: Radio<bool>(
                          value: true,
                          groupValue: selectedIndices.contains(index),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedIndices.add(index);
                              } else {
                                selectedIndices.remove(index);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              AppButton.appButton("Next", onTap: () {
                if (selectedIndices.isNotEmpty) {
                  print(
                      "Selected Rules: ${selectedIndices.map((i) => rules[i]).toList()}");
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please select at least one rule.")),
                  );
                }
              }),
            ],
          ),
        ),
        const SizedBox(
          height: 70,
        )
      ],
    );
  }
}

//Alert Dialogue Widget used in HomePage
class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

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
                      push(context, YourRewardStatus());
                    }),
                  ),
                  Expanded(
                    child: AppButton.appButtonwithspecificRadius("NO",
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(12)),
                        textColor: AppTheme.appColor,
                        backgroundColor: Colors.transparent,
                        borderColor: Colors.transparent, onTap: () {
                      push(context, AiPowered());
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
