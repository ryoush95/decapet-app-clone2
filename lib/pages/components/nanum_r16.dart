import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';

class NanumR16 extends StatelessWidget {
  final text;
  final color;
  final weight;
  final TextAlign? align;
  final height;
  final maxLine;
  NanumR16({
    Key? key,
    this.text,
    this.color = AppColor_Primary,
    this.weight = FW.bold, // or 'semi_bold'
    this.align = TextAlign.center,
    this.height = 1.0,
    this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.PD(color, 16, weight: weight, height: height),
      textAlign: align,
      maxLines: maxLine ?? 1,
    );
  }
}