import 'package:decapet/helpers/transition.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/h28.dart';

import '../components/simple_header.dart';
import '../tab_main.dart';

class SignupFinishPage extends StatefulWidget {
  @override
  SignupFinishPageState createState() => SignupFinishPageState();
}

class SignupFinishPageState extends BaseState<SignupFinishPage> {

  bool isValid = false;


  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onAgree() {
    Navigator.pushReplacement(
    context, SlideRightTransRoute(builder: (context) => TabMainPage()));
   }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
        isLoading: isLoading,
        child: Column(

        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleHeader(
            title: LanguageService.trans("signup"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
          child:SingleChildScrollView(
            child: Column(
              children:[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      H28(
                        text: LanguageService.trans("welcome"),
                        weight: FW.medium,
                        height: 1.7,
                        align: TextAlign.left,
                      ),
                      H28(
                        text: LanguageService.trans("welcome_contents"),
                        weight: FW.bold,
                        height: 1.5,
                        align: TextAlign.left,
                      ),
                      const SizedBox(height: 40),
                      Image.asset('assets/signup_finish.png',
                          width:330, height: 330),
                    ],

                  ),

                ),

                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MainTextButton(
                    text: LanguageService.trans("getting_started"),
                    backgroundColor: AppColor_Primary,
                    style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                    //width: 330,
                    height: 58,
                    disableBackground: !isValid
                        ? AppColor_Primary_Disable
                        : Colors.transparent,
                    onPressed: () {
                      onAgree();
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          ),
       ],
      ),
    );
  }
}
