import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';

class NanumR20 extends StatelessWidget {
  final text;
  final color;
  final weight;
  final TextAlign? align;
  final height;
  NanumR20({
    Key? key,
    this.text,
    this.color = AppColor_Primary,
    this.weight = FW.bold, // or 'semi_bold'
    this.align = TextAlign.center,
    this.height = 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.PD(color, 20, weight: weight, height: height),
      textAlign: align,
    );
  }
}