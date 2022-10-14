import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/auth/signup_input.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/app_rect_allcheckbox.dart';
import 'package:decapet/pages/components/app_rect_checkbox.dart';
import 'package:decapet/pages/components/h16_u.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../components/simple_header.dart';

class SignupPage extends StatefulWidget {
  final signupType;
  final snsId;

  SignupPage({Key? key, this.signupType = 'normal', this.snsId = ''}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends BaseState<SignupPage> {
  bool isValid = false;
  bool isALL = false;
  bool isTerm = false;
  bool isPolicy = false;
  bool isPush = false;
  bool isMaketing = false;
  int code = 0;
  int isSendCode = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void checkValid(bool flag) {
    setState(() {
      if (isPolicy && isTerm) {
        isValid = true;
      } else {
        isValid = false;
      }

      if (isPolicy && isTerm && isPush && isMaketing)
        isALL = true;
      else
        isALL = false;
    });
  }
  void onSendCode(int code) {
    setState(() {
      this.code = code;
      isSendCode = code;
    });
  }
  void onNext() {
    if (isValid) {
      Navigator.push(context, SlideRightTransRoute(builder: (context) => SignupInputPage(isEdit: false, signupType: widget.signupType, snsId: widget.snsId, onSendCode: onSendCode,)));
    }
  }

  void showAgreeDialog(type) {
    String title = "";
    String url = "";
    if (type == "term") {
      title = LanguageService.trans("termsofservice");
      url = TERMS_ULR;
    } else if (type == "policy") {
      title = LanguageService.trans("policy_agree_title");
      url = POLICY_ULR;
    } else if (type == "push") {
      title = LanguageService.trans("push_agree_title");
      url = API_BASE_URL + "api/App/term?type=" + type;
    } else if (type == "marketing") {
      title = LanguageService.trans("marketing_agree_title");
      url = API_BASE_URL + "api/App/term?type=" + type;
    }
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 150),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(children: [
                    // H22(
                    //   text: title,
                    // ),
                    Expanded(child: Container()),
                    MainTextButton(
                      text: LanguageService.trans("close"),
                      backgroundColor: Colors.transparent,
                      style: AppTextStyle.PD(Colors.blue, 18, weight: FW.medium),
                      width: 58,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: InAppWebView(
                    gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                    initialOptions: InAppWebViewGroupOptions(
                        android: AndroidInAppWebViewOptions(useHybridComposition: true, textZoom: 50 * 5 // it makes 2 times bigger
                            )),
                    onLoadStart: (controller, url) => {
                      setState(() {
                        showLoading();
                      })
                    },
                    onLoadStop: (controller, url) => {
                      setState(() {
                        hideLoading();
                      })
                    },
                    initialUrlRequest: URLRequest(url: Uri.parse(url)),
                  ),
                ),
                const SizedBox(height: 20),
                MainTextButton(
                  height: 58,
                  backgroundColor: AppColor_Primary,
                  style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                  text: LanguageService.trans("do_agree"),
                  onPressed: () {
                    setState(() {
                      if (type == "term") {
                        isTerm = true;
                      } else if (type == "policy") {
                        isPolicy = true;
                      } else if (type == "push") {
                        isPush = true;
                      } else if (type == "marketing") {
                        isMaketing = true;
                      }
                    });
                    checkValid(true);
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: H24B(
                        text: LanguageService.trans("signup_select_terms"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: H24B(
                        text: LanguageService.trans("signup_select_terms1"),
                      ),
                    ),
                    const SizedBox(height: 30),
                    AppRectALLCheckbox(
                      text: "모든 약관을 확인했으며 이에 동의합니다.",
                      textcolor: isALL ? AppColor_BlackText : AppColor_GrayText,
                      checked: isALL ? true : false,
                      onChecked: (checked) {
                        setState(() {
                          isPolicy = isTerm = isPush = isMaketing = isALL = checked!;
                          checkValid(true);
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        AppRectCheckbox(
                          text: LanguageService.trans("signup_terms_agree"),
                          checked: isTerm ? true : false,
                          onChecked: (checked) {
                            setState(() {
                              isTerm = checked!;
                              checkValid(true);
                            });
                          },
                          isContent: false,
                        ),
                        InkWell(
                            onTap: () {
                              showAgreeDialog("term");
                            },
                            child: H16U(
                              text: LanguageService.trans("signup_terms_agree"),
                              weight: FW.medium,
                              color: isTerm ? AppColor_BlackText : AppColor_GrayText,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        AppRectCheckbox(
                          text: LanguageService.trans("signup_policy_agree"),
                          checked: isPolicy ? true : false,
                          isContent: false,
                          onChecked: (checked) {
                            setState(() {
                              isPolicy = checked!;
                              checkValid(true);
                            });
                          },
                        ),
                        InkWell(
                            onTap: () {
                              showAgreeDialog("policy");
                            },
                            child: H16U(
                              text: LanguageService.trans("signup_policy_agree"),
                              weight: FW.medium,
                              color: isPolicy ? AppColor_BlackText : AppColor_GrayText,
                            ))
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        AppRectCheckbox(
                          text: LanguageService.trans("signup_push_agree"),
                          checked: isPush ? true : false,
                          isContent: false,
                          onChecked: (checked) {
                            setState(() {
                              isPush = checked!;
                              checkValid(true);
                            });
                          },
                        ),
                        InkWell(
                            onTap: () {
                              //showAgreeDialog("push");
                              setState(() {
                                isPush = !isPush;
                                checkValid(true);
                              });
                            },
                            child: H16U(
                              text: LanguageService.trans("signup_push_agree"),
                              weight: FW.medium,
                              color: isPush ? AppColor_BlackText : AppColor_GrayText,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        AppRectCheckbox(
                          text: LanguageService.trans("signup_marketing_agree"),
                          checked: isMaketing ? true : false,
                          isContent: false,
                          onChecked: (checked) {
                            setState(() {
                              isMaketing = checked!;
                              checkValid(true);
                            });
                          },
                        ),
                        InkWell(
                            onTap: () {
                              //showAgreeDialog("marketing");
                              setState(() {
                                isMaketing = !isMaketing;
                                checkValid(true);
                              });
                            },
                            child: H16U(
                              text: LanguageService.trans("signup_maketing_agree"),
                              weight: FW.medium,
                              color: isMaketing ? AppColor_BlackText : AppColor_GrayText,
                            ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 23),
                        Expanded(
                          child: Text(
                            LanguageService.trans("signup_description"),
                            style: AppTextStyle.PD(Colors.blue, 14, weight: FW.medium, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ]))),
                  const SizedBox(height: 20),
                  Center(
                    child: MainTextButton(
                      text: LanguageService.trans("signup_next"),
                      backgroundColor: AppColor_Primary,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                      //width: 330,
                      height: 58,
                      disable: !isValid,
                      disableBackground: !isValid ? AppColor_Primary_Disable : Colors.transparent,
                      onPressed: () {
                        onNext();
                      },
                    ),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
