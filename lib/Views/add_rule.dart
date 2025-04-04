import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/screen_sizes.dart';
import 'package:task_trader/Services/rule_service.dart';
import 'package:task_trader/Views/del_rule.dart';

class AddNewRule extends StatefulWidget {
  const AddNewRule({super.key});

  @override
  State<AddNewRule> createState() => _AddNewRuleState();
}

class _AddNewRuleState extends State<AddNewRule> {
  final TextEditingController _newRule = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: "Create Rule",
        fontsize: 25,
        fontWeight: FontWeight.w800,
        color: AppTheme.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            AppText.appText("Enter New Rule Below",
                textColor: AppTheme.white,
                fontSize: 20,
                fontWeight: FontWeight.w400),
            SizedBox(height: 20),
            CustomAppFormField(
              texthint: "Enter New Rule",
              controller: _newRule,
            ),
            SizedBox(
              height: 20,
            ),
            Spacer(),
            // Container(
            //     width: ScreenSize(context).width,
            //     height: 480,
            //     decoration:
            //         BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //     child: DelRules()),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _newRule,
                builder: (context, value, child) {
                  return AppButton.appButton(
                    "Create",
                    width: ScreenSize(context).width,
                    height: 62,
                    radius: 28.0,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    onTap: value.text.trimLeft().isNotEmpty
                        ? () async {
                            FocusManager.instance.primaryFocus?.unfocus(); //
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            );

                            await RulesService().addNewRules(value.text);

                            _newRule.clear();
                            if (!context.mounted) return;
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: "Rule Added Succesfully",
                            );
                          }
                        : () {
                            Fluttertoast.showToast(
                              msg: "Please enter a rule",
                            );
                          },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dialogue for Successfully Added New Rule
class NewRuleDialog extends StatefulWidget {
  const NewRuleDialog({super.key});

  @override
  State<NewRuleDialog> createState() => _NewRuleDialogState();
}

class _NewRuleDialogState extends State<NewRuleDialog> {
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
                "Rule Added Successfully",
                fontSize: 26,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                textColor: AppTheme.appColor,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: AppButton.appButtonwithspecificRadius("OK",
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(12)),
                        backgroundColor: AppTheme.appColor,
                        borderColor: AppTheme.appColor, onTap: () {
                      Navigator.of(context).pop();
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
