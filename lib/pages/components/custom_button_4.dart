import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/base/page_layout.dart';

import 'h10.dart';
import 'h14.dart';
import 'h16.dart';

class CustomButton4 extends StatelessWidget {
  final text;
  final fontcolor;
  final onPressed;


  CustomButton4({
    Key? key,
    this.text,
    this.fontcolor,
    this.onPressed,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFE6E7E7),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            //border: Border.all(color: Colors.black)
        ),
        child: Center(
          child: H16(
            text: text,
            weight: FW.semi_bold,
            align: TextAlign.center,
            color: fontcolor,
          ),
        ),

      ),
    );
  }
}
