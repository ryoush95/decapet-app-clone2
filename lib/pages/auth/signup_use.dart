import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h24_b.dart';

import '../components/simple_header.dart';
import 'signup_finish.dart';

class SignupUsePage extends StatefulWidget {
  SignupUsePage(
      {Key? key,
        required this.email,
        required this.pwd,
        required this.name,
        required this.birthday,
        required this.phone,
        required this.joinPath,
        required this.referId,
        required this.zipCode,
        required this.address1,
        required this.address2,
        required this.target,
        required this.gPushKey,
        required this.signupType,
      }) : super(key: key);

  String email;
  String pwd;
  String name;
  String birthday;
  String phone;
  String joinPath;
  String referId;
  String zipCode;
  String address1;
  String address2;
  String target;
  String gPushKey;
  String signupType;

  @override
  SignupUsePageState createState() => SignupUsePageState();
}

class SignupUsePageState extends BaseState<SignupUsePage> {
  bool isValid = true;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onAgree() {
    Navigator.push(context,
        SlideRightTransRoute(builder: (context) => SignupFinishPage()));
  }

  void onSignup() {
    if (!isValid) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading();
    try {
      api.signUp(
              widget.email,
              widget.pwd,
              widget.name,
              widget.birthday,
              widget.phone,
              widget.joinPath,
              widget.referId,
              widget.zipCode,
              widget.address1,
              widget.address2,
              widget.target,
              widget.gPushKey,
              widget.signupType)
          .then((value) {
        hideLoading();
        if (value.result == 0) {
          value.data!.pwd = widget.pwd;
          user.setInfo(value.data);
          Navigator.push(context,
              SlideRightTransRoute(builder: (context) => SignupFinishPage()));
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
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
            title: LanguageService.trans("signup"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            H24B(
                              text: LanguageService.trans("decapet_use_menu"),
                              color: AppColor_Input_Title,
                              height: 1.1,
                            ),
                            const SizedBox(width: 10),
                            Center(
                              child: Image.asset('assets/foot.png',
                                  width: 30, height: 30),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        H16(
                          text:
                              LanguageService.trans("signup_main_description"),
                          maxLine: 4,
                          weight: FW.medium,
                          height: 1.7,
                          align: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 290,
                    width: 360,
                    padding: const EdgeInsets.only(left: 30),
                    decoration: BoxDecoration(
                        color: AppColor_Light_Blue,
                        border:
                            Border.all(color: AppColor_Light_Blue, width: 1.0),
                        borderRadius: BorderRadius.circular(10)),
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
                              text: LanguageService.trans("dt_of_pets"),
                              weight: FW.bold,
                              align: TextAlign.left,
                            ),
                            H16(
                              text:
                                  LanguageService.trans("dt_of_pets_contents"),
                              weight: FW.medium,
                              align: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        H16(
                          text: "서비스를 제공합니다.",
                          weight: FW.medium,
                          align: TextAlign.left,
                        ),
                        const SizedBox(height: 50),
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
                              text: LanguageService.trans(
                                  "pet_health_information"),
                              weight: FW.bold,
                              align: TextAlign.left,
                            ),
                            const SizedBox(width: 5),
                            H16(
                              text: LanguageService.trans(
                                  "pet_health_information_contents1"),
                              weight: FW.medium,
                              maxLine: 2,
                              align: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        H16(
                          text: LanguageService.trans(
                              "pet_health_information_contents2"),
                          weight: FW.medium,
                          align: TextAlign.left,
                        ),
                        const SizedBox(height: 50),
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
                              text: LanguageService.trans("platform_service"),
                              weight: FW.bold,
                              align: TextAlign.left,
                            ),
                            const SizedBox(width: 5),
                            H16(
                              text: LanguageService.trans(
                                  "platform_service_contents1"),
                              weight: FW.medium,
                              align: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        H16(
                          text: LanguageService.trans(
                              "platform_service_contents2"),
                          weight: FW.medium,
                          maxLine: 2,
                          align: TextAlign.left,
                          height: 1.5,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainTextButton(
                      text: LanguageService.trans("agree"),
                      backgroundColor: AppColor_Primary,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                      //width: 360,
                      height: 58,
                      // disableBackground: !isValid
                      //     ? AppColor_Primary_Disable
                      //     : Colors.transparent,
                      onPressed: () {
                        onSignup();
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
