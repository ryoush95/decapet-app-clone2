import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'h14.dart';
import 'h16.dart';

class AppCheckbox extends StatelessWidget {
  final padding;

  AppCheckbox(
      {Key? key,
      required this.text,
      required this.checked,
      required this.onChecked,
      this.maxLine,
      this.color,
      this.font_size,
      this.height,
      this.algin,
      this.padding,
      this.withBorder = false})
      : super(key: key);

  String text;
  bool checked = false;
  final void Function(bool? checked) onChecked;
  bool withBorder = false;
  int? maxLine = 1;
  TextAlign? algin = TextAlign.center;
  double? height = 1.0;
  double? font_size = 16;
  Color? color = AppColor_BlackText;

  @override
  Widget build(BuildContext context) {
    if (withBorder) {
      return InkWell(
        child: Container(
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                    color: checked
                        ? AppColor_Primary
                        : AppColor_Selector_Border)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      checked
                          ? 'assets/ic_blue_check.png'
                          : 'assets/ic_circle_off.png',
                      height: 22),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.PD(
                        color?? AppColor_BlackText, font_size ?? 14,
                        weight: FW.medium, height: height ?? 1),
                    textAlign: algin,
                    maxLines: maxLine,
                  )
                ],
              ),
            )),
        onTap: () {
          onChecked(checked);
        },
      );
    } else {
      return InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
                checked
                    ? 'assets/ic_blue_check.png'
                    : 'assets/ic_circle_off.png',
                height: 22),
            const SizedBox(width: 8),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.PD(color?? AppColor_BlackText, font_size ?? 14,
                  weight: FW.medium, height: height ?? 1),
              textAlign: algin,
              maxLines: maxLine,
            )
          ],
        ),
        onTap: () {
          onChecked(checked);
        },
      );
    }
  }
}
