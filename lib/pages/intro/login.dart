import 'dart:io';

import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/helpers/validation_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/auth/find.dart';
import 'package:decapet/pages/auth/signup.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/underline_input.dart';
import 'package:decapet/pages/tab_main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BaseState<LoginPage> {
  var idInputController = TextEditingController();
  var pwdInputController = TextEditingController();
  String email = "";
  String pwd = "";
  bool isValid = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void checkValid() {
    setState(() {
      isValid = validEmail(email) && pwd.isNotEmpty;
    });
  }

  void onLogin() {
    if (!isValid) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading();
    try {
      String target = "";
      if (Platform.isAndroid) {
        target = "android";
      } else {
        target = "ios";
      }
      api.login(email, pwd, target, gPushKey, "normal").then((value) {
        hideLoading();
        if (value.result == 0) {
          value.data!.pwd = pwd;
          user.setInfo(value.data);
          Navigator.pushReplacement(context, SlideRightTransRoute(builder: (context) => TabMainPage()));
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void onSignup() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => SignupPage()));
  }

  void onFindIdPressed() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => FindFragment(type: 0)));
  }

  void onFindPasswdPressed() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => FindFragment(type: 1)));
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
        isLoading: isLoading,
        isAvoidResize: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            child: Container(child: Image.asset('assets/btn_back.png', width: 10)),
                            onTap: onBackPressed,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 70),
                H24B(
                  text: LanguageService.trans("login_title"),
                  color: AppColor_Primary,
                ),
                const SizedBox(height: 50),
                H14(
                  text: LanguageService.trans("email"),
                  weight: FW.medium,
                  color: AppColor_Input_Title,
                ),
                UnderlineInput(
                  controller: idInputController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(),
                  placeholder: LanguageService.trans("input_email"),
                  onChanged: (text) => {email = text, checkValid()},
                ),
                const SizedBox(height: 50),
                H14(
                  text: LanguageService.trans("password"),
                  weight: FW.medium,
                  color: AppColor_Input_Title,
                ),
                UnderlineInput(
                  controller: pwdInputController,
                  keyboardType: TextInputType.text,
                  isSecure: true,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => {onLogin()},
                  placeholder: LanguageService.trans("input_passwd"),
                  onChanged: (text) => {pwd = text, checkValid()},
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: H14(
                        text: LanguageService.trans("find_id"),
                        weight: FW.medium,
                        color: AppColor_Input_Title,
                      ),
                      onTap: onFindIdPressed,
                    ),
                    const SizedBox(width: 15),
                    H14(
                      text: LanguageService.trans("delimiter"),
                      weight: FW.medium,
                      color: AppColor_Input_Title,
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      child: H14(
                        text: LanguageService.trans("find_passwd"),
                        weight: FW.medium,
                        color: AppColor_Input_Title,
                      ),
                      onTap: onFindPasswdPressed,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: MainTextButton(
                    text: LanguageService.trans("login_caption"),
                    backgroundColor: AppColor_Primary,
                    style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                    height: 58,
                    disable: !isValid,
                    disableBackground: !isValid ? AppColor_Primary_Disable : Colors.transparent,
                    onPressed: () {
                      onLogin();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: gStartInfo.stable,
                  child: Center(
                    child: MainTextButton(
                      text: LanguageService.trans("signup"),
                      style: AppTextStyle.PD(AppColor_Input_Title, 18),
                      height: 58,
                      backgroundColor: Colors.transparent,
                      borderColor: AppColor_Gray,
                      showBorder: true,
                      onPressed: () {
                        onSignup();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
