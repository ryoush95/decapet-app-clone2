import 'package:flutter/material.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';

import 'h14.dart';

class CustomButton2 extends StatelessWidget {
  final text;
  final onPressed;
  final style;
  double? width;
  double? height;
  Color? backgroundColor;
  Color? disableBackground;
  Color? textColor;
  bool? showBorder;
  double? radius;
  bool? disable;
  ImageProvider? image;

  CustomButton2({
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
    this.image,
  }) : super(key: key) {
    this.width ??= double.infinity;
    this.height ??= 53;
    this.showBorder ??= false;
    this.backgroundColor ??= AppColor_Primary;
    this.disableBackground ??= AppColor_Primary;
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
        //padding: const EdgeInsets.only(left: 20),
        child: Image.asset("assets/ic_more.png",)
      )
    );
  }
}
