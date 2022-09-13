import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/pet/register_pet_first.dart';
import 'package:flutter/material.dart';

class WidgetRegPet extends StatelessWidget {
  WidgetRegPet({
    Key? key,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 40),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: AppColor_Light_Blue,
        border: Border.all(color: Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Center(
            child: H20(text: LanguageService.trans("title_reg_pet"), color: AppColor_Primary, weight: FW.medium),
          ),
          const SizedBox(height: 25),
          Center(
            child: Image.asset('assets/ic_intro_logo.png', width: 80, height: 80),
          ),
          const SizedBox(height: 25),
          // Center(
          //   child: Image.asset('assets/add_circle_black_24dp.png', width: 15, height: 15),
          // ),
          const SizedBox(height: 30),
          Visibility(
            visible: true, //!isRegistered,
            child: Column(
              children: [
                H16(text: LanguageService.trans("reg_pet_prefix"), height: 1.5, weight: FW.medium, maxLine: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    H16(
                      text: LanguageService.trans("reg_pet_suffix"),
                      height: 1.5,
                      weight: FW.medium,
                      align: TextAlign.center,
                    ),
                    // Image.asset('assets/add_circle_black_24dp.png', width: 14, height: 14),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: MainTextButton(
              text: LanguageService.trans("title_reg_pet"),
              backgroundColor: AppColor_Primary,
              style: AppTextStyle.PD(Colors.white, 14, weight: FW.semi_bold),
              width: 300,
              height: 35,
              radius: 6.0,
              onPressed: () {
                Navigator.push(context, SlideRightTransRoute(builder: (context) => RegisterPetFirstPage()));
              },
            ),
          )
        ],
      ),
    );
  }
}
