import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/global/local_service.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/chart_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/home/write_receipt_review.dart';
import 'package:decapet/pages/home/write_receipt_review_start.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class MyChildTreatmentCharTreatment extends StatefulWidget {
  int id;
  String status;

  MyChildTreatmentCharTreatment({
    Key? key,
    required this.id,
    required this.status,
  }) : super(key: key);

  @override
  MyChildTreatmentCharTreatmentState createState() => MyChildTreatmentCharTreatmentState();
}

class MyChildTreatmentCharTreatmentState extends BaseState<MyChildTreatmentCharTreatment> {
  ChartDto item = ChartDto();
  List<String> symptoms = [];
  String dateString = "";
  var months = [
    LanguageService.trans('january'),
    LanguageService.trans('february'),
    LanguageService.trans('march'),
    LanguageService.trans('april'),
    LanguageService.trans('may'),
    LanguageService.trans('june'),
    LanguageService.trans('july'),
    LanguageService.trans('august'),
    LanguageService.trans('september'),
    LanguageService.trans('october'),
    LanguageService.trans('november'),
    LanguageService.trans('december'),
  ];

  @override
  void initState() {
    super.initState();
    loadChartDetail();
  }

  void loadChartDetail() {
    showLoading();
    try {
      api.view_chart(user.info.access_token, widget.id).then((value) {
        hideLoading();
        if (value.result == 0) {
          item = value.data!;
          item.status = widget.status;
          symptoms.addAll(item.symptoms.split(","));
          DateTime itemDate = dateFormat.parse(item.date);
          dateString = sprintf("20%d년 %s %02d일", [itemDate.year % 100, months[itemDate.month - 1], itemDate.day]);
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  Future<void> goCheckOutMyReviews() async {
    int showGuide = await LocalService.getShowReviewGuide();
    if (showGuide == 1) {
      Navigator.push(
          context,
          SlideRightTransRoute(
              builder: (context) => WriteReceiptReviewPage(
                    medicalUid: widget.id,
                    hospitalName: item.hospital_name,
                    hospitalUid: 0,
                    reviewId: 0,
                  )));
    } else {
      Navigator.push(
          context,
          SlideRightTransRoute(
              builder: (context) => WriteReceiptReviewStartPage(
                    medicalUid: widget.id,
                    hospitalName: item.hospital_name,
                    hospitalUid: 0,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleHeader(
            title: LanguageService.trans("treatment_chart"),
            onBackPressed: onBackPressed,
            maxline: 2,
          ),
          Container(
            height: 8,
            color: const Color.fromARGB(255, 245, 245, 245),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      H20(
                        text: LanguageService.trans("treatment"),
                        color: const Color.fromARGB(255, 26, 141, 240),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      H20(
                        text: dateString,
                        color: AppColor_36383C,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      H16(
                        text: item.hospital_name,
                        weight: FW.medium,
                        color: AppColor_36383C.withOpacity(0.8),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      H16(
                        text: item.disease,
                        weight: FW.medium,
                        color: AppColor_36383C.withOpacity(0.4),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  H20(
                    text: LanguageService.trans("Symptom"),
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F8FE),
                              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                              border: Border.all(width: 1, color: const Color(0xFFD1E8FC)),
                            ),
                            child: Center(
                              child: H14(
                                text: symptoms[index],
                                color: const Color.fromARGB(255, 26, 141, 240),
                                align: TextAlign.center,
                                weight: FW.medium,
                              ),
                            ));
                      },
                      itemCount: symptoms.length),
                  const SizedBox(height: 52),
                  H18(
                    text: LanguageService.trans("hospital_visited"),
                    color: AppColor_36383C,
                  ),
                  const SizedBox(height: 12),
                  H16(
                    text: item.hospital_name,
                    color: AppColor_36383C.withOpacity(0.6),
                    weight: FW.medium,
                  ),
                  const SizedBox(height: 52),
                  H18(
                    text: LanguageService.trans("vet_teacher"),
                    color: AppColor_36383C,
                  ),
                  const SizedBox(height: 12),
                  H16(
                    text: item.veterinarian,
                    color: AppColor_36383C.withOpacity(0.8),
                  ),
                  const SizedBox(height: 8),
                  H12(
                    text: LanguageService.trans("License_number") + item.vet_registration_number,
                    color: AppColor_36383C.withOpacity(0.4),
                  ),
                  const SizedBox(height: 52),
                  H18(
                    text: LanguageService.trans("veterinarian_consultation_contents"),
                    color: AppColor_36383C,
                  ),
                  const SizedBox(height: 12),
                  H16(
                    text: item.description,
                    color: AppColor_36383C.withOpacity(0.6),
                    align: TextAlign.start,
                    weight: FW.medium,
                    maxLine: 30,
                  ),
                  const SizedBox(height: 52),
                  H18(
                    text: LanguageService.trans("Diagnosis"),
                    color: AppColor_36383C,
                  ),
                  const SizedBox(height: 17),
                  H12(
                    text: item.disease,
                    color: AppColor_36383C.withOpacity(0.6),
                  ),
                  const SizedBox(height: 59),
                  H18(
                    text: LanguageService.trans("pre_future_plans"),
                    color: AppColor_36383C,
                  ),
                  const SizedBox(height: 17),
                  H12(
                    text: item.prescription,
                    color: AppColor_36383C.withOpacity(0.6),
                  ),
                  const SizedBox(height: 55),
                  InkWell(
                    onTap: goCheckOutMyReviews,
                    child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                          color: widget.status == "no_review" ? AppColor_36383C : Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            width: 1,
                            color: AppColor_36383C,
                          ),
                        ),
                        child: Center(
                          child: H18(
                            text: widget.status == "no_review" ? LanguageService.trans("write_review") : LanguageService.trans("check_out_my_reviews"),
                            color: widget.status == "no_review" ? Colors.white : AppColor_36383C,
                            align: TextAlign.center,
                            weight: FW.semi_bold,
                          ),
                        )),
                  ),
                  const SizedBox(height: 62),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
