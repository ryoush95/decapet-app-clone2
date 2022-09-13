import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';

class H16 extends StatelessWidget {
  final String text;
  final color;
  final FW? weight;
  final TextAlign? align;
  final height;
  final maxLine;
  H16({
    Key? key,
    required this.text,
    this.color = AppColor_BlackText,
    this.weight = FW.bold,
    this.align = TextAlign.start,
    this.height = 1.0,
    this.maxLine
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