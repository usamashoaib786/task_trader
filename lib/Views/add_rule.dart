import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_field.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/screen_sizes.dart';

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
        leadingIcon: Images.backIconBlack,
        title: "Create Rule",
        fontsize: 20,
        fontWeight: FontWeight.w600,
        color: AppTheme.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            AppText.appText("Enter New Rule Below ",
                textColor: AppTheme.white,
                fontSize: 20,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 20,
            ),
            CustomAppFormField(
              texthint: "Enter New Rule",
              controller: _newRule,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: AppButton.appButton("Create",
                  width: ScreenSize(context).width,
                  height: 62,
                  radius: 28.0,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
