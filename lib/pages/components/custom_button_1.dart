import 'package:flutter/material.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';

import 'h14.dart';

class CustomButton1 extends StatelessWidget {
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

  CustomButton1({
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
        decoration: BoxDecoration(
            border: showBorder == false
                ? Border.all(color: Colors.transparent)
                : Border.all(width: 1, color: AppColor_BlackText),
            borderRadius: BorderRadius.circular(radius!),
            color: disable == null || !disable! ? backgroundColor: disableBackground),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            Flexible(
              fit: FlexFit.tight,
              flex: 4,
              //child: Center(

                child: H14(
                  text: LanguageService.trans(text),
                  color: AppColor_Gray,
                  weight: FW.semi_bold,
                  align: TextAlign.left,
                  maxLine: 2),
              //),
            ),
            //const SizedBox(width: 100),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Image.asset(
                  'assets/ic_white_right.png',
                  width: 15,
                  height: 15,
                  alignment: Alignment.center),
            ),
          ],
        ),

      ),
    );
  }
}
