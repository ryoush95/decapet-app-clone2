import 'package:flutter/material.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/app_colors.dart';

import 'package:decapet/pages/components/h18.dart';

class FindHospitalHeader extends StatelessWidget {
  final title;
  final onIconPressed;
  final badge;

  FindHospitalHeader({Key? key,
    this.title,
    this.onIconPressed,
    this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset('assets/ic_alarm.png', width: 20)
                ),
                onTap: onIconPressed,
              )
          ),
          Center(
            child: H18(text: title, color: AppColor_Primary, weight: FW.bold),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                height: 30,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColor_Primary),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(
                    badge,
                    style: AppTextStyle.PD(AppColor_Primary, 14, weight: FW.medium, height: 1.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
