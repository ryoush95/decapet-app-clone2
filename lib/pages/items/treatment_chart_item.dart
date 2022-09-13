import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/chart_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/home/bt_result.dart';
import 'package:decapet/pages/home/my_child_treatment_chart_treatment.dart';
import 'package:flutter/material.dart';

class TreatmentChartItem extends StatefulWidget {
  final ChartDto item;
  final int petUid;
  final onReviewWrite;
  final onClickItem;

  TreatmentChartItem({Key? key, required this.item, required this.petUid, required this.onClickItem, required this.onReviewWrite}) : super(key: key);

  @override
  TreatmentChartItemState createState() => TreatmentChartItemState();
}

class TreatmentChartItemState extends BaseState<TreatmentChartItem> {
  String reviewStatus = 'no_review';

  @override
  void initState() {
    super.initState();
    reviewStatus = widget.item.status;

    event.on<ReviewWrite>().listen((event) {
      if (mounted) {
        if (widget.item.id == event.medicalUid) {
          setState(() {
            widget.item.status == 'testing';
            reviewStatus = 'testing';
          });
        }
      }
    });
  }

  void goDetail() {
    if (widget.item.type == "medical_chart") {
      Navigator.push(context, SlideRightTransRoute(builder: (context) => MyChildTreatmentCharTreatment(id: widget.item.id, status: widget.item.status)));
    } else {
      Navigator.push(context, SlideRightTransRoute(builder: (context) => BTResultPage(petUid: widget.petUid, date: widget.item.date)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: goDetail,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            height: 100,
            color: AppColor_White,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          H20(
                            text: widget.item.type == "medical_chart" ? LanguageService.trans("treatment") : LanguageService.trans("blood_collection"),
                            weight: FW.bold,
                            align: TextAlign.left,
                            color: widget.item.type == "medical_chart" ? AppColor_Primary : AppColor_Red,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          H20(
                              text: getDateFormatString(DateTime.parse(widget.item.date), 'yyyy') + LanguageService.trans("year") + " " + getDateFormatString(DateTime.parse(widget.item.date), 'MMMM d') + LanguageService.trans("day1"),
                              weight: FW.bold,
                              align: TextAlign.left,
                              color: AppColor_BlackText),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            //width: 200,
                            constraints: const BoxConstraints(maxWidth: 180),
                            child: H16(
                              maxLine: 1,
                              text: LanguageService.trans(widget.item.hospital_name),
                              weight: FW.medium,
                              align: TextAlign.left,
                              color: AppColor_Input_Title,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Visibility(
                              visible: widget.item.type == "medical_chart",
                              child: H14(
                                text: LanguageService.trans(widget.item.disease),
                                weight: FW.medium,
                                align: TextAlign.left,
                                color: AppColor_Hint,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.item.type == "medical_chart" && reviewStatus != "checked",
                  child: MainTextButton(
                    text: reviewStatus == "no_review" ? LanguageService.trans("review_write") : LanguageService.trans("check_review"),
                    backgroundColor: AppColor_BlackText,
                    style: AppTextStyle.PD(Colors.white, 14, weight: FW.bold),
                    height: 35,
                    width: 80,
                    onPressed: widget.onReviewWrite,
                  ),
                )
              ],
            ),
          ),
        ),
        const AppDivider(height: 8.0, color: AppColor_Divider)
      ],
    );
  }
}
