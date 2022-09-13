import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/alarm_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/material.dart';

class AlarmItem extends StatefulWidget {
  AlarmDto item;

  AlarmItem({Key? key, required this.item}) : super(key: key);

  @override
  AlarmItemState createState() => AlarmItemState();
}

class AlarmItemState extends BaseState<AlarmItem> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {}

  void toggleDetail() {
    // TODO goto detail page
  }

  String getAlarmType(String type) {
    if (type == "reservation") {
      return LanguageService.trans("reservation");
    } else if (type == "reservation") {
      return LanguageService.trans("notice");
    } else {
      return LanguageService.trans("Alarm");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor_White,
      //onTap: toggleDetail,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: H16(text: getAlarmType(widget.item.notification_type), weight: FW.bold, maxLine: 1, align: TextAlign.left),
          ),

          // Content
          const SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: H14(text: widget.item.title, weight: FW.regular, height: 1.5, maxLine: 10, align: TextAlign.left),
          ),
          const SizedBox(height: 17),
          // Time
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: H12(
              text: widget.item.created_at,
              weight: FW.medium,
              maxLine: 1,
              align: TextAlign.left,
              color: AppColor_Table_DateTime,
            ),
          ),
          const SizedBox(height: 25),
          Container(color: AppColor_Gray, height: 1),
        ],
      ),
    );
  }
}
