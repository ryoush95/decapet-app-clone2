import 'package:decapet/models/dto/user_dto.dart';
import 'package:decapet/pages/auth/signup_input.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/intro/first.dart';
import 'package:decapet/pages/intro/start.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/local_service.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/photo_dialog.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/items/profile_item.dart';

class MyInfoPage extends StatefulWidget {
  @override
  MyInfoPageState createState() => MyInfoPageState();
}

class MyInfoPageState extends BaseState<MyInfoPage> {
  String profileImage = "";
  final imagePicker = ImagePicker();
  int code = 0;
  int isSendCode = 0;
  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  void onSendCode(int code) {
    setState(() {
      this.code = code;
      isSendCode = code;
    });
  }
  void onEdit() {
    Future<dynamic> result = Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => SignupInputPage(isEdit: true, onSendCode: onSendCode,)));

    result.then((value) {
      if (value) {
        Navigator.of(context).pop();
      }
    });
  }

  void onLogout() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H20(text: LanguageService.trans('mypage_logout'), height: 1.5),
                    InkWell(
                      child: H20(
                        text: LanguageService.trans('close'),
                        weight: FW.medium,
                        color: AppColor_Primary,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              H18(text: LanguageService.trans("msg_confirm_logout")),
              const SizedBox(height: 50),
              MainTextButton(
                text: LanguageService.trans('mypage_logout'),
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  user.setInfo(UserDto());
                  Navigator.pushReplacement(context, SlideRightTransRoute(builder: (context) => FirstPage()));
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        isLoading: isLoading,
        child: Column(
          children: [
            SimpleHeader(
              title: LanguageService.trans('My_Info'),
              onBackPressed: onBackPressed,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 43),
                    Observer(
                      builder: (_) => ProfileItem(
                          title: LanguageService.trans('email'),
                          content: user.info.email,
                          type: 0),
                    ),
                    Observer(
                      builder: (_) => ProfileItem(
                          title: LanguageService.trans('name'),
                          content: user.info.name,
                          type: 0),
                    ),
                    Observer(
                      builder: (_) => ProfileItem(
                          title: LanguageService.trans('birthday'),
                          content: user.info.birthday,
                          type: 0),
                    ),
                    Observer(
                      builder: (_) => ProfileItem(
                          title: LanguageService.trans('phone'),
                          content: user.info.phone_number,
                          type: 0),
                    ),
                    Observer(
                      builder: (_) => ProfileItem(
                          title: LanguageService.trans('address'),
                          content: user.info.address,
                          type: 0),
                    ),
                    Observer(
                      builder: (_) => ProfileItem(
                          title: LanguageService.trans('superscription_path'),
                          content: user.info.path,
                          type: 0),
                    ),
                    Observer(
                      builder: (_) => ProfileItem(
                          title: LanguageService.trans('Refferrer_ID'),
                          content: user.info.recommend_email,
                          type: 0),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MainTextButton(
                        text: LanguageService.trans("edit_your_info"),
                        backgroundColor: AppColor_Primary,
                        style:
                            AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                        height: 58,
                        onPressed: () {
                          onEdit();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: InkWell(
                          onTap: onLogout,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: H14(
                              text: LanguageService.trans("mypage_logout"),
                              color: AppColor_GrayText,
                              weight: FW.medium,
                            ),
                          )),
                    ),
                    const SizedBox(height: 38),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
