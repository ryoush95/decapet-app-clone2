import 'package:decapet/global/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';

class SlideBar extends StatelessWidget {
  double? width;
  double? height;
  double? min;
  double? max;
  double? value;
  Color? color;
  Color? backcolor;
  Color? frontcolor;

  SlideBar({
    Key? key,
    this.width,
    this.height,
    this.backcolor,
    this.frontcolor,
    this.color,
    this.min,
    this.max,
    this.value,
  }) : super(key: key) {
    this.width ??= 250;
    this.height ??= 5;
    this.color ??= AppColor_Primary;
    this.backcolor ??= AppColor_GrayBackround;
    this.frontcolor ??= AppColor_Primary_Disable;
    this.value ??= 1;
  }

  double? calcOffset(double max, double min, double width, double value)
  {
    double res = 0;
    if (value < min)
      res = value * 30 / min;
    else if (value > max){
      if (190 * (value - max)/(max-min) > width)
        res = width;
      else
        res = 210 + (value - max)/(max-min)*190;
    } else {
        res = (value - min)/(max-min)*190 + 30;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.centerLeft, children: [
      Container(
        width: width,
        height: height! * 3,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      Positioned(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backcolor,

            //borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
      ),
      Positioned(
        left: 30,
        child: Container(
          width: (width! * 0.75),
          height: height,
          decoration: BoxDecoration(
            color: frontcolor,

            //borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
      ),
      Positioned(
          left: calcOffset(max!, min!, width!, value!),//(width!-30) * value! / (max!),
          child: Container(
            child: Image.asset(
              "assets/icon_blue.png",
              width: 12,
              height: 12,
              color: color,
            ),
          )),
    ]);
  }
}
