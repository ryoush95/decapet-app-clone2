import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'h14.dart';
import 'h18.dart';

class AppRectALLCheckbox extends StatelessWidget {
  final padding;
  AppRectALLCheckbox(
      {Key? key,
      required this.text,
      required this.checked,
      required this.onChecked,
      this.textcolor,
      this.padding,
      this.withBorder = false})
      : super(key: key);

  String text;
  bool checked = false;
  final void Function(bool? checked) onChecked;
  bool withBorder = false;
  final textcolor;

  @override
  Widget build(BuildContext context) {
    if (withBorder) {
      return InkWell(
        child: Container(
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: checked? AppColor_Primary: AppColor_Selector_Border)),
            child: Center(
              child: Stack(
                children: [
                  Image.asset(
                    checked
                      ? 'assets/ic_rect_check_on.png'
                      : 'assets/ic_rect_check_off.png',
                      height: 22),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        H18(text: text, weight: FW.medium, color: textcolor,)
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
        onTap: () {

          onChecked(!checked);
        },
      );
    } else {
      return InkWell(
        child: Row(
          children: [
            Image.asset(
                checked
                    ? 'assets/ic_rect_check_on.png'
                    : 'assets/ic_rect_check_off.png',
                gaplessPlayback: true,
                height: 22),
            const SizedBox(width: 8),
            H18(text: text, weight: FW.medium, color: textcolor,)
          ],
        ),
        onTap: () {

          onChecked(!checked);
        },
      );
    }
  }
}
