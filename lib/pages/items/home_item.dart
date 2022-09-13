import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/round_container.dart';

class HomeItem extends StatefulWidget {
  @override
  HomeItemState createState() => HomeItemState();
}

class HomeItemState extends BaseState<HomeItem> {
  String title = 'Will it matter to the child?';
  String content =
      "Family is an important background in a child's life. Until the child becomes his parents at home, so he learns the basic way of living in the world. Family is an important background in a child's life. Until the child becomes his parents at home, so he learns the basic way of living in the world.";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child:H20(text: LanguageService.trans("title_reg_pet"), color: AppColor_Primary, weight: FW.medium),
          ),
          const SizedBox(height: 30),
          Center(
            child: Image.asset('assets/ic_intro_logo.png',
                width: 120, height: 120),
          ),
          const SizedBox(height: 30),
          Center(
            child: Image.asset('assets/add_circle_black_24dp.png',
                width: 20, height: 20),
          ),
          const SizedBox(height: 10),
          Center(
            child:H14(text: LanguageService.trans("reg_pet"),weight: FW.medium, maxLine: 3),
          ),
          const SizedBox(height: 30),
          MainTextButton(
            text: LanguageService.trans("title_reg_pet"),
            backgroundColor: Colors.blue,
            style: AppTextStyle.PD(
                Colors.white, 18, weight: FW.medium),
            width: 300,
            height: 58,
            onPressed: () {
              //onLogin();
            },
          ),
        ],
      ),
    );
  }
}
