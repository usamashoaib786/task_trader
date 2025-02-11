import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Image? leadingIcon;
  final FontWeight? fontWeight;
  final double? fontsize;
  final Color? color;
  const CustomAppBar(
      {super.key,
      this.title = "",
      this.actions,
      this.leadingIcon,
      this.fontWeight,
      this.fontsize,
      this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15),
      child: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
