import 'package:flutter/material.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Views/bottom_navigation_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Image? leadingIcon;
  final FontWeight? fontWeight;
  final double? fontsize;
  final Color? color;
  final bool? rewardPage;
  const CustomAppBar(
      {super.key,
      this.title = "",
      this.actions,
      this.leadingIcon,
      this.fontWeight,
      this.fontsize,
      this.color,
      this.rewardPage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15),
      child: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              if (rewardPage == true) {
                pushUntil(context, BottomNavView());
              } else {
                Navigator.pop(context);
              }
            },
            child: leadingIcon),
        title: Text(
          title,
          style: TextStyle(
              color: color ?? Colors.white,
              fontSize: fontsize ?? 18,
              fontWeight: fontWeight ?? FontWeight.w400),
        ),
        backgroundColor: Colors.transparent,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
