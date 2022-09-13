import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';

class H32B extends StatelessWidget {
  final text;
  FW weight;

  H32B({
    Key? key,
    this.text,
    required this.weight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.PD(AppColor_BlackText, 32, height: 1.5, weight: weight),
    );
  }
}