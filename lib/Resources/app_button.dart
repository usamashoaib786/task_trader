import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';

class AppButton {
  static Widget appButton(String text,
      {double? height,
      double? width,
      Color? backgroundColor,
      EdgeInsetsGeometry? padding,
      TextAlign? textAlign,
      Color? textColor,
      double? fontSize,
      GestureTapCallback? onTap,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      Color? borderColor,
      TextBaseline? textBaseline,
      TextOverflow? overflow,
      var radius,
      double? letterSpacing,
      bool underLine = false,
      bool fontFamily = false,
      bool? border,
      bool? blurContainer}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        width: width,
        height: height ?? 70,
        decoration: BoxDecoration(
            boxShadow: [
              blurContainer == true
                  ? const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      offset: Offset(0.0, 4))
                  : const BoxShadow()
            ],
            color: backgroundColor ?? AppTheme.appColor,
            borderRadius: BorderRadius.circular(radius ?? 25),
            border: border == false
                ? null
                : Border.all(
                    color: borderColor ?? AppTheme.appColor, width: 1)),
        child: AppText.appText(text,
            fontFamily: fontFamily,
            fontSize: fontSize ?? 20,
            textAlign: textAlign,
            fontWeight: fontWeight,
            textColor: textColor ?? Colors.white,
            overflow: overflow,
            letterSpacing: letterSpacing,
            textBaseline: textBaseline,
            fontStyle: fontStyle,
            underLine: underLine),
      ),
    );
  }

  static Widget appButtonwithspecificRadius(String text,
      {double? height,
      double? width,
      Color? backgroundColor,
      EdgeInsetsGeometry? padding,
      TextAlign? textAlign,
      Color? textColor,
      double? fontSize,
      GestureTapCallback? onTap,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      Color? borderColor,
      TextBaseline? textBaseline,
      TextOverflow? overflow,
      BorderRadius? borderRadius,
      double? letterSpacing,
      bool underLine = false,
      bool fontFamily = false,
      bool? border,
      bool? blurContainer}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        width: width,
        height: height ?? 70,
        decoration: BoxDecoration(
            boxShadow: [
              blurContainer == true
                  ? const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      offset: Offset(0.0, 4))
                  : const BoxShadow()
            ],
            color: backgroundColor ?? AppTheme.appColor,
            borderRadius: borderRadius,
            border: border == false
                ? null
                : Border.all(
                    color: borderColor ?? AppTheme.appColor, width: 1)),
        child: AppText.appText(text,
            fontFamily: fontFamily,
            fontSize: fontSize ?? 20,
            textAlign: textAlign,
            fontWeight: fontWeight,
            textColor: textColor ?? Colors.white,
            overflow: overflow,
            letterSpacing: letterSpacing,
            textBaseline: textBaseline,
            fontStyle: fontStyle,
            underLine: underLine),
      ),
    );
  }
}
