import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:flutter/src/painting/edge_insets.dart';

class Badge extends StatelessWidget {
  final String content;
  double font_size;
  FW font_style;

  Badge({
    Key? key,
    required this.content,
    required this.font_size,
    required this.font_style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color color_val = AppColor_BlackText;// as int;

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      //height: 20,
      //width: 30,
      decoration: BoxDecoration(
          //border: Border.all(width: 1, color: AppColor_Gray),
          borderRadius: BorderRadius.circular(10),
          color: AppColor_Gray
      ),
      child: Text(
        content,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle.PD(AppColor_BlackText, font_size, weight: font_style, height: 1.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
