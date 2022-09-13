import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/point_dto.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:flutter/material.dart';

import 'h12.dart';
import 'h14.dart';

class PointHistoryItem extends StatelessWidget {
  final PointDto item;
  String? icon;
  String? typeText;
  String? inOut;
  String? point;

  PointHistoryItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color_val = AppColor_BlackText; // as int;

    if (item.type == "general_receipt") {
      icon = 'assets/character_smile.png';
      typeText = LanguageService.trans("point_text_general_receipt");
      inOut = item.point >= 0 ? LanguageService.trans("earn") : LanguageService.trans("use");
      point = (item.point >= 0 ? (item.point == 0 ? "" : "+") : "-") + formatAmount(item.point.abs()) + " " + LanguageService.trans("p");
      color_val = item.point >= 0 ? AppColor_Primary : AppColor_Red;
    } else if (item.type == "medical_receipt") {
      icon = 'assets/book.png';
      typeText = LanguageService.trans("point_text_medical_receipt");
      inOut = item.point >= 0 ? LanguageService.trans("earn") : LanguageService.trans("use");
      point = (item.point >= 0 ? (item.point == 0 ? "" : "+") : "-") + formatAmount(item.point.abs()) + " " + LanguageService.trans("p");
      color_val = item.point >= 0 ? AppColor_Primary : AppColor_Red;
    } else if (item.type == "welcome") {
      icon = 'assets/character_smile2.png';
      typeText = LanguageService.trans("point_text_welcome");
      inOut = item.point >= 0 ? LanguageService.trans("earn") : LanguageService.trans("use");
      point = (item.point >= 0 ? (item.point == 0 ? "" : "+") : "-") + formatAmount(item.point.abs()) + " " + LanguageService.trans("p");
      color_val = item.point >= 0 ? AppColor_Primary : AppColor_Red;
    } else if (item.type == "payment") {
      icon = 'assets/character_smile.png';
      typeText = LanguageService.trans("point_text_payment");
      inOut = item.point >= 0 ? LanguageService.trans("earn") : LanguageService.trans("use");
      point = (item.point >= 0 ? (item.point == 0 ? "" : "+") : "-") + formatAmount(item.point.abs()) + " " + LanguageService.trans("p");
      color_val = item.point >= 0 ? AppColor_Primary : AppColor_Red;
    } else if (item.type == "recommend") {
      icon = 'assets/character_smile.png';
      typeText = LanguageService.trans("point_text_recommend");
      inOut = item.point >= 0 ? LanguageService.trans("earn") : LanguageService.trans("use");
      point = (item.point >= 0 ? (item.point == 0 ? "" : "+") : "-") + formatAmount(item.point.abs()) + " " + LanguageService.trans("p");
      color_val = item.point >= 0 ? AppColor_Primary : AppColor_Red;
    }

    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 30),
      //padding: const EdgeInsets.only(right: 20),
      height: 77,
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon!,
                width: 25,
                height: 25,
                alignment: Alignment.center,
              ),

              const SizedBox(
                width: 13,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H14(
                    text: typeText!,
                    weight: FW.medium,
                    align: TextAlign.left,
                    color: AppColor_BlackText,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  H12(
                    text: getDateFormatString(DateTime.parse(item.created_at), "MM.dd(EEEE) HH:mm ") + inOut!,
                    weight: FW.medium,
                    align: TextAlign.left,
                    color: AppColor_Icon,
                  ),
                ],
              ),

              //const SizedBox(width: 13,),
              Expanded(
                //fit: FlexFit.tight,
                //flex: 5,
                child: H14(
                  text: point!,
                  weight: FW.medium,
                  align: TextAlign.end,
                  color: color_val,
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          const AppDivider(height: 1.0, color: AppColor_Gray)
        ],
      ),
    );
  }
}
