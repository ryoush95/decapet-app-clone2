import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/base/page_layout.dart';

import 'h10.dart';
import 'h18.dart';

class ImgWithButton extends StatelessWidget {
  final text;
  final onPressed;
  final imagePath;
  final color;
  final bg_color;
  final image_color;
  final FW? weight;
  final TextAlign? align;
  final height;
  final maxLine;
  final font_size;
  final enable_border;

  ImgWithButton(
      {Key? key,
      this.text,
      this.imagePath,
      this.onPressed,
      this.color = AppColor_BlackText,
      this.image_color,
      this.bg_color = AppColor_White,
      this.weight = FW.bold,
      this.align = TextAlign.center,
      this.height = 1.0,
      this.font_size = 18.0,
      this.enable_border = false,
      this.maxLine})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 55,
        // width: 165,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: enable_border
              ? Border.all(color: Colors.black)
              : Border.all(color: bg_color),
          boxShadow: const [
            BoxShadow(
              color: AppColor_Gray,
              blurRadius: 5.0, // soften the shadow
            )
          ],
          color: bg_color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, width: 25, color: image_color),
            const SizedBox(width: 15),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.PD(color, font_size,
                  weight: weight, height: height),
              textAlign: align,
              maxLines: maxLine ?? 2,
            ),
          ],
        ),
      ),
    );
  }
}
