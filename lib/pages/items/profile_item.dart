import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String content;
  final int type; // 0 : view, 1: edit

  ProfileItem({
    Key? key,
    required this.title,
    required this.content,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 30),
      //padding: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.fromLTRB(20, 0, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H14(
            text: title,
            weight: FW.bold,
            color: AppColor_Input_Title,
          ),
          const SizedBox(height: 15),
          H16(
            text: content,
            align: TextAlign.start,
            weight: FW.medium,
            color: AppColor_Table_DateTime,
            maxLine: 2,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
