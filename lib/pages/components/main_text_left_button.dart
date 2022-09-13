import 'package:decapet/global/app_colors.dart';
import 'package:flutter/material.dart';

class MainTextLeftButton extends StatelessWidget {
  final text;
  final onPressed;
  final style;
  double? width;
  double? height;
  Color? backgroundColor;
  Color? disableBackground;
  Color? textColor;
  Color? borderColor;
  bool? showBorder;
  double? radius;
  bool? disable;

  MainTextLeftButton({
    Key? key,
    this.text,
    this.onPressed,
    this.style,
    this.width,
    this.height,
    this.backgroundColor,
    this.disableBackground,
    this.showBorder,
    this.radius,
    this.disable,
    this.borderColor,
  }) : super(key: key) {
    this.width ??= double.infinity;
    this.height ??= 48;
    this.showBorder ??= false;
    this.backgroundColor ??= AppColor_Primary;
    this.disableBackground ??= AppColor_Primary;
    this.radius ??= 6;
    this.disable ??= false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        decoration: BoxDecoration(border: showBorder == false ? Border.all(color: Colors.transparent) : Border.all(width: 1, color: borderColor ?? Colors.transparent), borderRadius: BorderRadius.circular(radius!), color: disable == null || !disable! ? backgroundColor : disableBackground),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
