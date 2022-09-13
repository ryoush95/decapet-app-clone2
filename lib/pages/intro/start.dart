import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/nanum_r16.dart';
import 'package:decapet/pages/components/nanum_r20.dart';
import 'package:decapet/pages/intro/first.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends BaseState<StartPage> {
  String version = "";
  @override
  void initState() {
    super.initState();
    getVersion().then((value) => {
          setState(() {
            version = value;
          })
        });
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onStart() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => FirstPage()));
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 120),
            Center(
              child: Image.asset('assets/ic_intro_logo.png', width: 120, height: 120),
            ),
            const SizedBox(height: 30),
            Center(
              child: Image.asset('assets/ic_intro_logo_text.png', width: 153, height: 24),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NanumR20(
                text: LanguageService.trans("project_title"),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NanumR16(
                text: LanguageService.trans("project_desc"),
                weight: FW.medium,
                color: AppColor_Intro_Description,
                height: 1.4,
                maxLine: 10,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MainTextButton(
                text: LanguageService.trans("project_start"),
                backgroundColor: AppColor_Primary,
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                //width: 342,
                height: 58,
                onPressed: () {
                  onStart();
                },
              ),
            ),
            const SizedBox(height: 70),
            Center(
              child: H12(text: version, color: AppColor_GrayText),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
