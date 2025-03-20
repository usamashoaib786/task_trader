import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final VoidCallback onYesTap;
  final VoidCallback onNoTap;

  const CustomDialog({
    super.key,
    required this.title,
    required this.onYesTap,
    required this.onNoTap,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppText.appText(
                title,
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
                    child: AppButton.appButtonwithspecificRadius(
                      "YES",
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(12)),
                      backgroundColor: AppTheme.appColor,
                      borderColor: AppTheme.appColor,
                      onTap: onYesTap,
                    ),
                  ),
                  Expanded(
                    child: AppButton.appButtonwithspecificRadius(
                      "NO",
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(12)),
                      textColor: AppTheme.appColor,
                      backgroundColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      onTap: onNoTap,
                    ),
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
