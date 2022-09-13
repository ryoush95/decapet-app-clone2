import 'package:decapet/global/app_colors.dart';
import 'package:flutter/material.dart';


class AppDivider extends StatelessWidget {
  final color;
  final height;
  const AppDivider({
    Key? key,
    this.height = 10.0,
    this.color = AppColor_Gray,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      width: double.infinity,
    );
  }
}