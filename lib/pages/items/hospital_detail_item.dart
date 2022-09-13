import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/models/dto/hospital_detail_item_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/material.dart';

class HospitalDetailItem extends StatefulWidget {
  final HospitalDetailItemDto item;

  HospitalDetailItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  HospitalDetailItemState createState() => HospitalDetailItemState();
}

class HospitalDetailItemState extends BaseState<HospitalDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 49,
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white, border: Border.all(color: AppColor_Primary)),
        child: Stack(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: int.parse(widget.item.percent.replaceAll("%", "")),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 49,
                        color: AppColor_Light_Blue,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (100 - int.parse(widget.item.percent.replaceAll("%", ""))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 49,
                        color: Colors.transparent,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Image.asset(widget.item.imgPath, width: 20, height: 20), const SizedBox(width: 10), Flexible(flex: 1, child: Text(widget.item.content, style: AppTextStyle.PD(AppColor_Primary, 16.0, weight: FW.medium)))],
                      ),
                    ),
                    H16(
                      text: widget.item.percent,
                      weight: FW.medium,
                      color: AppColor_Primary,
                      align: TextAlign.right,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
