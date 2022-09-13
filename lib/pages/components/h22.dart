import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';

class H22 extends StatelessWidget {
  final text;
  final height;
  const H22({
    Key? key,
    this.text,
    this.height = 1.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.PD(AppColor_BlackText, 22, height: height),
    );
  }
}