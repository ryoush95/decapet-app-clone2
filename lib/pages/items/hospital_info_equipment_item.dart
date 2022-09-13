import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/material.dart';

class HospitalInfoEquipmentItem extends StatelessWidget {
  final String title;
  String text;

  HospitalInfoEquipmentItem({Key? key, required this.title, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            //padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            //decoration: BoxDecoration(
            //    borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H16(
                  text: title,
                  align: TextAlign.left,
                  height: 2.0,
                  color: AppColor_36383C.withOpacity(0.8),
                ),
                SizedBox(
                  height: 2,
                ),
                H14(
                  text: text,
                  weight: FW.medium,
                  align: TextAlign.left,
                  height: 1.5,
                  maxLine: 2,
                  color: AppColor_36383C.withOpacity(0.6),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          AppDivider(height: 1.0, color: Color(0xFFEDEEEF)),
        ],
      ),
    );
  }
}
