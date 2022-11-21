//add by hch
import 'dart:io';

import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/auth/signup.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h32_b.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/tab_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'login.dart';

// import '../tab_main.dart';

class FirstPage extends StatefulWidget {
  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends BaseState<FirstPage> {
  //TODO YJ
  // static final FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
  String signupType = 'normal';
  late String id = "shpsh";
  late String password = "";

  @override
  void initState() {
    super.initState();
    // load();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onLogin() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => LoginPage()));
  }

  void onSnsLogin(String type) {
    setState(() {
      signupType = type;
    });

    onAuth();
  }

  Future<void> onAuth() async {
    if (signupType == "apple") {
      // TODO YJ
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      id = credential.userIdentifier!;
      password = credential.userIdentifier!;
      reqLogin();
    } else if (signupType == "naver") {
      // TODO YJ
      NaverLoginResult res = await FlutterNaverLogin.logIn();
      setState(() {
        id = res.account.id;
        password = res.account.id;
        FlutterNaverLogin.logOut();
        reqLogin();
      });
      reqLogin();
    } else if (signupType == "kakao") {
      // try {
      //   // TODO YJ
      //   final result = await kakaoSignIn.logIn();
      //
      //   final result1 = await kakaoSignIn.getUserMe();
      //   final KakaoAccountResult? account = result1.account;
      //   if (account != null) {
      //     id = account.userID!;
      //     password = account.userID!;
      //     kakaoSignIn.logOut();
      //     reqLogin();
      //   }
      // } on PlatformException catch (e) {
      //   print("${e.code} ${e.message}");
      // }
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();

          var user = await UserApi.instance.me();
          id = user.id.toString();
          password = id;
          reqLogin();
          showToast('카카오톡으로 로그인 성공');
        } catch (error) {
          showToast('카카오톡으로 로그인 실패 $error');

          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            return;
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          try {
            await UserApi.instance.loginWithKakaoAccount();

            var user = await UserApi.instance.me();
            id = user.id.toString();
            password = id;
            await UserApi.instance.logout();
            reqLogin();
            showToast('카카오계정으로 로그인 성공');
          } catch (error) {
            showToast('카카오계정으로 로그인 실패 $error');
          }
        }
      }
      reqLogin();
    }
  }

  // void load() async {
  //   // Kakao SDK Init (Set NATIVE_APP_KEY)
  //   await kakaoSignIn.init('8358269776945a3b1fdedf8a7f09c6da');
  // }

  void reqLogin() {
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading();
    try {
      String target = "";
      if (Platform.isAndroid) {
        target = "android";
      } else {
        target = "ios";
      }
      api.login(id, password, target, gPushKey, signupType).then((value) {
        hideLoading();
        if (value.result == 0) {
          value.data!.pwd = password;
          user.setInfo(value.data);
          Navigator.pushReplacement(context, SlideRightTransRoute(builder: (context) => TabMainPage()));
        } else {
          Navigator.push(context, SlideRightTransRoute(builder: (context) => SignupPage(signupType: signupType, snsId: id)));
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
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 120),
            H32B(
              text: LanguageService.trans("first_title"),
              weight: FW.regular,
            ),
            H32B(
              text: LanguageService.trans("app_name"),
              weight: FW.bold,
            ),
            Visibility(
              visible: gStartInfo.stable,
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  InkWell(
                    onTap: () {
                      onSnsLogin('kakao');
                    },
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 58,
                            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                            decoration: const BoxDecoration(color: Color(0xFFFFEC00), borderRadius: BorderRadius.all(Radius.circular(16))),
                            child: Stack(
                              children: [
                                Center(
                                  child: H18(
                                    text: LanguageService.trans("kakao_login"),
                                    weight: FW.medium,
                                    height: 1.5,
                                    color: const Color(0xFF401C1D),
                                  ),
                                ),
                                Positioned(
                                  child: Image.asset('assets/ic_kakaotalk.png', width: 26, height: 24),
                                  left: 24,
                                  top: 17,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      onSnsLogin('naver');
                    },
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 58,
                            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                            decoration: const BoxDecoration(color: Color(0xFF5ECB6A), borderRadius: BorderRadius.all(Radius.circular(16))),
                            child: Stack(
                              children: [
                                Center(
                                  child: H18(
                                    text: LanguageService.trans("naver_login"),
                                    weight: FW.medium,
                                    height: 1.5,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  child: Image.asset('assets/ic_naver.png', width: 24, height: 24),
                                  left: 24,
                                  top: 17,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: Platform.isIOS,
                    child: const SizedBox(height: 10),
                  ),
                  Visibility(
                    visible: Platform.isIOS,
                    child: InkWell(
                      onTap: () {
                        onLogin();
                      },
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 58,
                              margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.0,
                                    color: AppColor_BlackText,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: Stack(
                                children: [
                                  Center(
                                    child: H18(
                                      text: LanguageService.trans("apple_login"),
                                      weight: FW.medium,
                                      height: 1.5,
                                      color: AppColor_BlackText,
                                    ),
                                  ),
                                  Positioned(
                                    child: Image.asset('assets/ic_apple.png', width: 24, height: 29),
                                    left: 24,
                                    top: 17,
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Visibility(
              visible: !gStartInfo.stable,
              child: Expanded(
                child: Container(),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: MainTextButton(
                  text: LanguageService.trans("login_title"),
                  backgroundColor: Colors.transparent,
                  showBorder: true,
                  borderColor: Colors.blue,
                  height: 58,
                  style: AppTextStyle.PD(Colors.blue, 18, weight: FW.medium),
                  //width: 350,
                  onPressed: () {
                    onLogin();
                  },
                ),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
