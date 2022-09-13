import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/local_service.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/app_rect_check.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../components/simple_header.dart';
import 'write_receipt_review.dart';

class WriteReceiptReviewStartPage extends StatefulWidget {
  int medicalUid;
  int hospitalUid;
  String hospitalName;

  WriteReceiptReviewStartPage({
    Key? key,
    required this.medicalUid,
    required this.hospitalUid,
    required this.hospitalName,
  }) : super(key: key);

  @override
  WriteReceiptReviewStartPageState createState() => WriteReceiptReviewStartPageState();
}

class WriteReceiptReviewStartPageState extends BaseState<WriteReceiptReviewStartPage> {
  bool isShowNextTime = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onStart() {
    LocalService.setShowReviewGuide(isShowNextTime ? 1 : 0);
    Navigator.pushReplacement(
        context,
        SlideRightTransRoute(
            builder: (context) => WriteReceiptReviewPage(
                  medicalUid: widget.medicalUid,
                  hospitalName: widget.hospitalName,
                  hospitalUid: widget.hospitalUid,
                  reviewId: 0,
                )));
  }

  void onShowChecked() {
    isShowNextTime = !isShowNextTime;
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans("write_receipt_review"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        H24B(
                          text: LanguageService.trans("writing_guide_desc_1"),
                          color: AppColor_Intro_Description,
                          height: 1.1,
                          maxLine: 2,
                        ),
                        Row(
                          children: [
                            H24B(
                              text: LanguageService.trans("writing_guide_desc_2"),
                              color: AppColor_Intro_Description,
                              height: 1.1,
                              maxLine: 2,
                            ),
                            const SizedBox(width: 10),
                            Center(
                              child: Image.asset('assets/foot.png', width: 30, height: 30),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SubstringHighlight(
                          text: LanguageService.trans("please_register"),
                          term: LanguageService.trans("please_register_hl"),
                          textStyle: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.medium, height: 1.5),
                          textStyleHighlight: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.medium, underline: true),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        H16(
                          text: LanguageService.trans("if_you_register"),
                          maxLine: 2,
                          weight: FW.bold,
                          height: 1.5,
                          align: TextAlign.left,
                        ),
                        const SizedBox(height: 40),
                        Container(
                          height: 330,
                          width: 340,
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(color: AppColor_GrayBackround, borderRadius: BorderRadius.circular(10)),
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
                        const SizedBox(height: 30),
                        AppRectCheck(text: LanguageService.trans("review_check_desc"), checked: isShowNextTime, onChecked: (checked) => {isShowNextTime = checked!}, withBorder: false),
                        const SizedBox(height: 30),
                        MainTextButton(
                          text: LanguageService.trans("start"),
                          backgroundColor: AppColor_Primary,
                          height: 58,
                          style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                          onPressed: () {
                            onStart();
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
