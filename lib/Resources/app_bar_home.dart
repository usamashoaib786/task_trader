import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Views/notification.dart';
import 'package:task_trader/Views/reward_screen.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final String userDisplayName ;
  const AppBarHome({super.key, required this.userDisplayName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Row(
        children: [
          Image.asset(
            "assets/images/memoji-Boys.png",
            height: 50,
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            height: 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.appText("Hi, $userDisplayName!",
                    textColor: AppTheme.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
                SizedBox(
                  height: 5,
                ),
                AppText.appText("Welcome to Task Trader",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    textColor: Color(0xFF8198A5)),
              ],
            ),
          ),
          Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  push(context, YourRewardStatus(isHomeScreen: true,));
                },
                child: Image.asset(
                  "assets/images/bronzeBadge.png",
                  height: 30,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              // InkWell(
              //   onTap: () {
              //     push(context, NotificationsScreen());
              //   },
              //   child: Icon(
              //     Icons.notifications,
              //     color: AppTheme.whiteColor,
              //     size: 30,
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75);
}
