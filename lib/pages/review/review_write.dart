import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/bloodtest/bloodtest_select_hospital.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/review/can_write_review.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

class ReviewWritePage extends StatefulWidget {
  @override
  ReviewWritePageState createState() => ReviewWritePageState();
}

class ReviewWritePageState extends BaseState<ReviewWritePage> {
  bool isShowNextTime = false;
  List<Widget> descList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onStart() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => CanWriteReviewPage()));
  }

  void goOwnReview() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => BloodTestAppSelectHospitalPage(fromPath: "review")));
  }

  void onShowChecked() {
    isShowNextTime = !isShowNextTime;
  }

  void loadReviewDesc() {
    for (int i = 0; i < 4; i++) {
      descList.add(
        Column(
          children: [
            Row(
              children: [
                Center(
                  child: Image.asset(
                    'assets/ic_green_check.png',
                    width: 15,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 5),
                H16(
                  text: LanguageService.trans("review_diagnose_desc1"),
                  weight: FW.medium,
                  align: TextAlign.left,
                  height: 1.5,
                ),
              ],
            ),
            H16(
              text: LanguageService.trans("review_diagnose_desc2"),
              weight: FW.medium,
              align: TextAlign.left,
              height: 1.5,
            ),
            const SizedBox(height: 15),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    loadReviewDesc();
    return PageLayout(
      isLoading: isLoading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(width: 10),
                  Row(
                    children: [
                      Expanded(
                        child: H18(
                          text: LanguageService.trans("review_write_guide"),
                          color: AppColor_Intro_Description,
                          height: 1.1,
                          maxLine: 2,
                          align: TextAlign.start,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Image.asset('assets/foot.png', width: 20, height: 20),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SubstringHighlight(
                    text: LanguageService.trans("reg_diagnose"),
                    term: LanguageService.trans("reg_diagnose_hl"),
                    textStyle: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.medium, height: 1.5),
                    textStyleHighlight: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.medium, underline: true),
                    textAlign: TextAlign.left,
                  ),
                  // const SizedBox(height: 10),
                  H16(
                    text: LanguageService.trans("after_review"),
                    maxLine: 2,
                    weight: FW.medium,
                    height: 1.5,
                    align: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 24, right: 24),
              padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
              decoration: BoxDecoration(color: AppColor_GrayBackround, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/ic_green_check.png',
                          width: 15,
                          height: 20,
                        ),
                      ),
                      const SizedBox(width: 5),
                      H16(
                        text: LanguageService.trans("review_desc_1"),
                        weight: FW.medium,
                        align: TextAlign.left,
                        height: 1.5,
                      ),
                    ],
                  ),
                  H16(
                    text: LanguageService.trans("review_desc_1_uncheck"),
                    weight: FW.medium,
                    align: TextAlign.left,
                    height: 1.5,
                    maxLine: 2,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/ic_green_check.png',
                          width: 15,
                          height: 20,
                        ),
                      ),
                      const SizedBox(width: 5),
                      H16(
                        text: LanguageService.trans("review_desc_2"),
                        weight: FW.medium,
                        align: TextAlign.left,
                        height: 1.5,
                      ),
                    ],
                  ),
                  H16(
                    text: LanguageService.trans("review_desc_2_uncheck"),
                    weight: FW.medium,
                    align: TextAlign.left,
                    height: 1.5,
                    maxLine: 2,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/ic_green_check.png',
                          width: 15,
                          height: 20,
                        ),
                      ),
                      const SizedBox(width: 5),
                      H16(
                        text: LanguageService.trans("review_desc_3"),
                        weight: FW.medium,
                        align: TextAlign.left,
                        height: 1.5,
                      ),
                    ],
                  ),
                  H16(
                    text: LanguageService.trans("review_desc_3_uncheck"),
                    weight: FW.medium,
                    align: TextAlign.left,
                    height: 1.5,
                    maxLine: 3,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/ic_green_check.png',
                          width: 15,
                          height: 20,
                        ),
                      ),
                      const SizedBox(width: 5),
                      H16(
                        text: LanguageService.trans("review_desc_4"),
                        weight: FW.medium,
                        align: TextAlign.left,
                        height: 1.5,
                      ),
                    ],
                  ),
                  H16(
                    text: LanguageService.trans("review_desc_4_uncheck"),
                    weight: FW.medium,
                    align: TextAlign.left,
                    height: 1.5,
                    maxLine: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MainTextButton(
                //width: 350,
                height: 50,
                text: LanguageService.trans("avail_review"),
                backgroundColor: AppColor_Primary,
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.medium),
                radius: 10.0,
                onPressed: () {
                  onStart();
                },
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MainTextButton(
                //width: 350,
                height: 50,
                text: LanguageService.trans("reg_own_review"),
                backgroundColor: Colors.transparent,
                style: AppTextStyle.PD(Colors.blue, 18, weight: FW.medium),
                radius: 10.0,
                showBorder: true,
                borderColor: AppColor_Primary,
                onPressed: () {
                  goOwnReview();
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
