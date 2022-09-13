import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final text;
  final onPressed;
  final style;
  double? width;
  double? height;
  Color? backgroundColor;
  Color? inActiveBackground;
  Color? textColor;
  Color? borderColor;
  bool? showBorder;
  double? radius;
  bool? disable;
  bool? active;

  TimeButton({
    Key? key,
    this.text,
    this.onPressed,
    this.style,
    this.width,
    this.height,
    this.backgroundColor,
    this.inActiveBackground,
    this.showBorder,
    this.radius,
    this.disable,
    this.borderColor,
    this.active,
  }) : super(key: key) {
    this.width ??= 80;
    this.height ??= 40;
    this.showBorder ??= false;
    this.backgroundColor ??= AppColor_Primary;
    this.inActiveBackground ??= Color(0xFFF2F8FE);
    this.radius ??= 5;
    this.disable ??= false;
    this.active ??= false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(border: showBorder == false ? Border.all(color: Colors.transparent) : Border.all(width: 1, color: borderColor ?? Colors.transparent), borderRadius: BorderRadius.circular(radius!), color: active == true ? backgroundColor : inActiveBackground),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.PD(active == true ? Colors.white : Colors.black, 18, weight: FW.medium),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
