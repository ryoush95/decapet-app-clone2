import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/reserve/reserve_history.dart';
import 'package:decapet/pages/tab_main.dart';
import 'package:flutter/material.dart';

class BloodTestAppCompletePage extends StatefulWidget {
  const BloodTestAppCompletePage({Key? key, required this.reservationId, required this.animalType}) : super(key: key);

  final reservationId;
  final animalType;

  @override
  BloodTestAppCompletePageState createState() => BloodTestAppCompletePageState();
}

class BloodTestAppCompletePageState extends BaseState<BloodTestAppCompletePage> {
  @override
  void initState() {
    super.initState();
  }

  void onInfoConfirm() {
    // Navigator.of(context).popUntil((route) => route.isFirst);
    // Navigator.push(
    //   context,
    //   SlideRightTransRoute(
    //     builder: (context) => ReserveDetailPage(
    //       reservationId: widget.reservationId,
    //     ),
    //   ),
    // );
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReserveHistoryPage()));
  }

  void onMainTo() {
    //Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, SlideRightTransRoute(builder: (context) => TabMainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: H18(text: LanguageService.trans("reservation_complete"), weight: FW.medium, maxLine: 2),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    H20(
                      text: LanguageService.trans("complete_message"),
                      weight: FW.bold,
                      maxLine: 3,
                      align: TextAlign.left,
                      height: 1.5,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(widget.animalType == "cat" ? "assets/ic_reserve_finish2.png" : "assets/ic_reserve_finish1.png"),
                        fit: BoxFit.fill,
                      )),
                    ),
                    const SizedBox(height: 30),
                    MainTextButton(
                      height: 58,
                      text: LanguageService.trans("info_confirm"),
                      backgroundColor: AppColor_Primary,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                      radius: 10.0,
                      onPressed: () {
                        onInfoConfirm();
                      },
                    ),
                    const SizedBox(height: 10),
                    MainTextButton(
                      height: 58,
                      text: LanguageService.trans("main_to"),
                      backgroundColor: AppColor_White,
                      style: AppTextStyle.PD(AppColor_Primary, 18, weight: FW.bold),
                      radius: 10.0,
                      borderColor: AppColor_Primary,
                      showBorder: true,
                      onPressed: () {
                        onMainTo();
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
