import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/chart_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:flutter/material.dart';

import '../components/h14.dart';

class ReviewCanItem extends StatefulWidget {
  final ChartDto item;
  final onWrite;
  final onViewChart;

  ReviewCanItem({Key? key, required this.item, required this.onWrite, required this.onViewChart}) : super(key: key);

  @override
  ReviewCanItemState createState() => ReviewCanItemState();
}

class ReviewCanItemState extends BaseState<ReviewCanItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor_White,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset("assets/inventory_black_24dp.png", width: 20, height: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      H14(text: LanguageService.trans("diagnosis"), color: AppColor_Primary, weight: FW.medium),
                      const SizedBox(height: 5),
                      H14(
                        text: widget.item.hospital_name,
                        weight: FW.medium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 0.1,
              color: Colors.black,
            ),
            const SizedBox(height: 15),
            H14(
              text: getDateFormatString(DateTime.parse(widget.item.visit_dt), "MMMEd") + " " + getDateFormatString(DateTime.parse(widget.item.visit_dt), "HH:mm" + " " + LanguageService.trans("visited_date1")),
              weight: FW.medium,
              height: 1.5,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainTextButton(
                  width: 150,
                  height: 35,
                  text: LanguageService.trans("review_write"),
                  backgroundColor: Colors.black87,
                  style: AppTextStyle.PD(Colors.white, 16, weight: FW.medium),
                  radius: 6.0,
                  onPressed: widget.onWrite,
                ),
                const SizedBox(width: 10),
                MainTextButton(
                  width: 150,
                  height: 35,
                  text: LanguageService.trans("view_medical_chart"),
                  backgroundColor: AppColor_Selector_Border.withOpacity(0.5),
                  style: AppTextStyle.PD(Colors.black, 16, weight: FW.medium),
                  radius: 6.0,
                  onPressed: widget.onViewChart,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}
