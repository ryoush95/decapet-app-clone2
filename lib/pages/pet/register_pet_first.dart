import 'package:decapet/helpers/transition.dart';
import 'package:decapet/pages/pet/register_pet_second.dart';
import 'package:decapet/pages/pet/register_pet_third.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/h16.dart';

import '../components/simple_header.dart';

class RegisterPetFirstPage extends StatefulWidget {
  @override
  RegisterPetFirstPageState createState() => RegisterPetFirstPageState();
}

class RegisterPetFirstPageState extends BaseState<RegisterPetFirstPage> {
  bool isHaveCard = true;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onNext() {
    if (isHaveCard) {
      Navigator.push(context,
          SlideRightTransRoute(builder: (context) => RegisterPetSecondPage()));
    } else {
      Navigator.push(
          context,
          SlideRightTransRoute(
              builder: (context) => RegisterPetThirdPage(
                    imageUrl: "",
                    registrationNumber: "",
                  )));
    }
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
            title: LanguageService.trans("register_your_pet"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        H16(
                          text: LanguageService.trans(
                              "register_first_pet_contents1"),
                          weight: FW.bold,
                          maxLine: 2,
                          height: 1.9,
                          align: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        MainTextButton(
                          text: LanguageService.trans(
                              "register_first_pet_contents2"),
                          style: AppTextStyle.PD(
                              isHaveCard ? Colors.blue : Colors.black26, 18,
                              weight: FW.bold),
                          //width: 360,
                          height: 120,
                          showBorder: isHaveCard,
                          borderColor: isHaveCard
                              ? Colors.lightBlueAccent
                              : Colors.transparent,
                          backgroundColor: isHaveCard
                              ? AppColor_Light_Blue
                              : AppColor_Light_Gray,
                          onPressed: () {
                            setState(() {
                              isHaveCard = true;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        MainTextButton(
                          text: LanguageService.trans(
                              "register_first_pet_contents3"),
                          backgroundColor: isHaveCard
                              ? AppColor_Light_Gray
                              : AppColor_Light_Blue,
                          style: AppTextStyle.PD(
                              isHaveCard ? Colors.black26 : Colors.blue, 18,
                              weight: FW.bold),
                          showBorder: isHaveCard ? false : true,
                          borderColor: isHaveCard
                              ? Colors.transparent
                              : Colors.lightBlueAccent,
                          //width: 360,
                          height: 120,
                          onPressed: () {
                            setState(() {
                              isHaveCard = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainTextButton(
                      text: LanguageService.trans("next"),
                      backgroundColor: AppColor_Primary,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                      //width: 360,

                      // disableBackground: !isValid
                      //     ? AppColor_Primary_Disable
                      //     : Colors.transparent,
                      onPressed: () {
                        onNext();
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
