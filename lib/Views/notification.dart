import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/screen_sizes.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<String> titles = [
    "Trade successfully executed",
    "You’ve reached Silver reward tier",
    "Reminder: Complete your trading setup.",
    "Tier Update: It looks like you've temporarily moved down a tier due to an incomplete task. Stay focused – with a little extra effort, you can earn back your Gold tier!",
  ];
  final List<String> subtitles = [
    "Apr 23, 2024",
    "Mar 18, 2024",
    "Fer 13, 2024",
    "Jan 08, 2024"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingIcon: Images.backIconBlack,
        title: "Notifications",
        fontsize: 20,
        fontWeight: FontWeight.w600,
        color: AppTheme.white,
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              width: ScreenSize(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: titles.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            notificationListTile(
                                title: titles[index],
                                subtitle: subtitles[index]),
                            if (index < titles.length - 1)
                              Divider(
                                color: AppTheme.appColor,
                              ),
                          ],
                        );
                      }),
                ],
              )),
        ],
      ),
    );
  }
}

Widget notificationListTile({
  required String title,
  required String subtitle,
}) {
  return ListTile(
    titleAlignment: ListTileTitleAlignment.titleHeight,
    leading: Icon(
      Icons.adjust,
      color: AppTheme.appColor,
    ),
    title: AppText.appText(title, fontSize: 19, fontWeight: FontWeight.w500),
    subtitle:
        AppText.appText(subtitle, fontSize: 16, fontWeight: FontWeight.w400),
  );
}
