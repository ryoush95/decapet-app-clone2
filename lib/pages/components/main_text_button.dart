import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';

class MainTextButton extends StatelessWidget {
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

  MainTextButton({
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
    this.height ??= 50;
    this.showBorder ??= false;
    this.backgroundColor ??= AppColor_Primary;
    this.disableBackground ??= AppColor_Primary_Disable;
    this.radius ??= 10;
    this.disable ??= false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: showBorder == false
                ? Border.all(color: Colors.transparent)
                : Border.all(width: 1, color: borderColor?? Colors.transparent),
            borderRadius: BorderRadius.circular(radius!),
            color: disable == null || !disable! ? backgroundColor: disableBackground),
        child:
        Center(
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
