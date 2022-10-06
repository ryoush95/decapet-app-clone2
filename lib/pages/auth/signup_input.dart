import 'dart:io';

import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/helpers/validation_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/user_dto.dart';
import 'package:decapet/pages/auth/address.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/selector.dart';
import 'package:decapet/pages/components/underline_input.dart';
import 'package:decapet/pages/intro/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../components/simple_header.dart';
import 'signup_use.dart';

class SignupInputPage extends StatefulWidget {
  final bool isEdit;
  final signupType;
  final snsId;

  const SignupInputPage({Key? key, required this.isEdit, this.signupType = 'normal', this.snsId = ''}) : super(key: key);

  @override
  SignupInputPageState createState() => SignupInputPageState();
}

class SignupInputPageState extends BaseState<SignupInputPage> {
  var emailController = TextEditingController();
  var pwdController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var zipCodeInputController = TextEditingController();
  var addr1InputController = TextEditingController();
  var addr2InputController = TextEditingController();
  var referInputController = TextEditingController();

  String email = "";
  String pwd = "";
  String name = "";
  String phone = "";
  String zipCode = "";
  String address1 = "";
  String address2 = "";
  String joinPath = "";
  String referId = "";
  String birth = "";
  DateTime? birthday;

  bool isValid = false;
  List<String> pathList = [];
  bool idValid = false;
  String target = "";

  void loadPathList() {
    showLoading();
    try {
      api.pathList().then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            pathList = value.data!.list;
          });
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
  void initState() {
    super.initState();
    loadPathList();
    if (Platform.isAndroid) {
      target = "android";
    } else {
      target = "ios";
    }
    if (widget.isEdit) {
      setState(() {
        idValid = true;
        emailController.text = user.info.email;
        email = user.info.email;
        pwdController.text = user.info.pwd;
        pwd = user.info.pwd;
        nameController.text = user.info.name;
        name = user.info.name;
        phoneController.text = user.info.phone_number;
        phone = user.info.phone_number;
        birthday = DateTime.parse(user.info.birthday);
        birth = user.info.birthday;
        zipCodeInputController.text = user.info.zip_code;
        zipCode = user.info.zip_code;
        addr1InputController.text = user.info.address;
        address1 = user.info.address;
        addr2InputController.text = user.info.address_detail;
        address2 = user.info.address_detail;
        joinPath = user.info.path;
        print(joinPath);
        referInputController.text = user.info.recommend_email;
        referId = user.info.recommend_email;
      });

      checkValid();
    }

    if (widget.signupType != "normal") {
      email = widget.snsId;
      emailController.text = widget.snsId;
      pwd = widget.snsId;
    }
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void checkValid() {
    if (widget.signupType == 'normal') {
      if (!validEmail(email) ||
          pwd.isEmpty ||
          name.isEmpty ||
          phone.isEmpty ||
          zipCode.isEmpty ||
          address1.isEmpty ||
          address2.isEmpty) {
        setState(() {
          isValid = false;
        });
      } else {
        if (idValid) {
          setState(() {
            isValid = true;
          });
        }
      }
    } else {
      idValid = true;
      if (pwd.isEmpty ||
          name.isEmpty ||
          phone.isEmpty ||
          zipCode.isEmpty ||
          address1.isEmpty ||
          address2.isEmpty) {
        setState(() {
          isValid = false;
        });
      } else {
        setState(() {
          isValid = true;
        });
      }
    }

    if (referId.isNotEmpty) {
      isValid = isValid && validEmail(referId);
    }
  }

  void onSignup() {
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
      api
          .signUp(
              email,
              pwd,
              name,
              getDateFormatString(birthday!, "yyyy-MM-dd"),
              phone,
              joinPath,
              referId,
              zipCode,
              address1,
              address2,
              target,
              gPushKey,
              widget.signupType)
          .then((value) {
        hideLoading();
        if (value.result == 0) {
          value.data!.pwd = pwd;
          user.setInfo(value.data);
          // Navigator.push(context, SlideRightTransRoute(builder: (context) => SignupUsePage()));
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void idCheck1() {
    showLoading();
    try {
      api.idCheck(email).then((value) {
        hideLoading();
        if (value.result == 0) {
          showToast("사용가능한 이메일입니다.");
          setState(() {
            idValid = true;
          });
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void onChangeProfile() {
    if (!isValid) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading();
    try {
      api.changeProfile(user.info.access_token, email, pwd, name, birth, phone,
              zipCode, address1, address2, joinPath, referId)
          .then((value) {
        hideLoading();
        if (value.result == 0) {
          value.data!.pwd = pwd;
          user.setInfo(value.data);
          if (widget.isEdit) {
            Navigator.of(context).pop(true);
          }
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  Future<void> onSearch() async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map received = await Navigator.push(context, SlideRightTransRoute(builder: (context) => AddressSearchPage()));
    setState(() {
      zipCode = received["postcode"];
      address1 = received["addr"];
      //address2 = received["jibun_addr"];
    });

    zipCodeInputController.text = zipCode;
    addr1InputController.text = address1;
    // addr2InputController.text = address2;

    checkValid();

    return;
  }

  void onWithdraw() {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H20(text: LanguageService.trans("withdraw"), height: 1.5),
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
              H18(text: LanguageService.trans("msg_confirm_withdraw")),
              const SizedBox(height: 50),
              MainTextButton(
                text: LanguageService.trans('withdraw'),
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                onPressed: () {
                  showLoading();
                  try {
                    api.signout(user.info.access_token).then((value) {
                      hideLoading();
                      if (value.result == 0) {
                        user.setInfo(UserDto());
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            SlideRightTransRoute(
                                builder: (context) => StartPage()));
                      } else {
                        showToast(value.msg!);
                      }
                    });
                  } on Exception catch (_, e) {
                    hideLoading();
                    showToast(LanguageService.trans("network_error"));
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  void onSelectBirthday() {
    FocusScope.of(context).requestFocus(FocusNode());
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900),
        maxTime: DateTime(2100), onChanged: (date) {
//          print('change $date');
    }, onConfirm: (date) {
      setState(() {
        birthday = date;
        birth = date.toString();
      });
    }, currentTime: birthday, locale: LocaleType.ko);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleHeader(
            title: widget.isEdit
                ? LanguageService.trans("edit_your_info")
                : LanguageService.trans("signup"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: !widget.isEdit,
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: H24B(
                                text: LanguageService.trans(
                                    "signupinputpage_description"),
                                color: AppColor_BlackText,
                                height: 1.5,
                                maxLine: 2,
                              ),
                            )),
                        const SizedBox(height: 13),
                        Visibility(
                          visible: widget.signupType == 'normal',
                          child: Visibility(
                            visible: !widget.isEdit,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                H14(
                                  text: LanguageService.trans("email"),
                                  weight: FW.medium,
                                  color: AppColor_Input_Title,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: UnderlineInput(
                                        controller: emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                        placeholder:
                                            LanguageService.trans("input_email"),
                                        height: 30,
                                        onChanged: (text) =>
                                            {email = text, checkValid()},
                                      ),
                                    ),
                                    Visibility(
                                      visible: !widget.isEdit,
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: MainTextButton(
                                          width: 70,
                                          style:
                                              AppTextStyle.PD(Colors.white, 14),
                                          text: "중복확인",
                                          disable: idValid,
                                          disableBackground: !isValid
                                              ? AppColor_Primary_Disable
                                              : Colors.transparent,
                                          onPressed: () {
                                            if (idValid) return;
                                            if (email.isEmpty) {
                                              showToast("이메일을 입력해주세요");
                                            } else if (!validEmail(email)) {
                                              showToast("이메일을 정확하게 입력해주세요");
                                            } else {
                                              node.unfocus();
                                              idCheck1();
                                              checkValid();
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                H14(
                                  text: LanguageService.trans("password"),
                                  weight: FW.medium,
                                  color: AppColor_Input_Title,
                                ),
                                const SizedBox(height: 10),
                                UnderlineInput(
                                  controller: pwdController,
                                  keyboardType: TextInputType.text,
                                  isSecure: true,
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () => node.nextFocus(),
                                  placeholder:
                                      LanguageService.trans("input_passwd"),
                                  height: 30,
                                  onChanged: (text) => {pwd = text, checkValid()},
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        H14(
                          text: LanguageService.trans("name"),
                          weight: FW.medium,
                          color: AppColor_Input_Title,
                        ),
                        const SizedBox(height: 10),
                        UnderlineInput(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          placeholder: LanguageService.trans("input_name"),
                          height: 30,
                          onChanged: (text) => {name = text, checkValid()},
                        ),
                        const SizedBox(height: 20),
                        H14(
                          text: LanguageService.trans("birthday"),
                          weight: FW.medium,
                          color: AppColor_Input_Title,
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: onSelectBirthday,
                          child: Container(
                            height: 25,
                            width: double.infinity,
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColor_Gray, width: 1))),
                            child: H16(
                              align: TextAlign.start,
                              weight: FW.medium,
                              text: birthday != null
                                  ? getDateFormatString(birthday!, "yyyy-MM-dd")
                                  : LanguageService.trans("birthday"),
                              color: birthday != null
                                  ? AppColor_BlackText
                                  : AppColor_Hint,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        H14(
                          text: LanguageService.trans("phone"),
                          weight: FW.medium,
                          color: AppColor_Input_Title,
                        ),
                        const SizedBox(height: 10),
                        UnderlineInput(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          maxLength: 11,
                          onEditingComplete: () => node.nextFocus(),
                          placeholder:
                              LanguageService.trans("input_only_number"),
                          height: 30,
                          onChanged: (text) {
                            phone = text;
                            checkValid();
                          },
                        ),
                        const SizedBox(height: 20),
                        H14(
                          text: LanguageService.trans("address"),
                          weight: FW.medium,
                          color: AppColor_Input_Title,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: UnderlineInput(
                                controller: zipCodeInputController,
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                textInputAction: TextInputAction.next,
                                placeholder: LanguageService.trans("post_number"),
                                height: 47,
                                onChanged: (text) => {zipCode = text, checkValid()},
                              ),
                            ),
                            const SizedBox(width: 10),
                            MainTextButton(
                              text: LanguageService.trans("search"),
                              backgroundColor: AppColor_Intro_Description,
                              style: AppTextStyle.PD(Colors.white, 16, weight: FW.medium),
                              width: 92,
                              height: 48,
                              onPressed: () {
                                onSearch();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        UnderlineInput(
                          controller: addr1InputController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          placeholder: LanguageService.trans("address1"),
                          height: 52,
                          onChanged: (text) => {address1 = text, checkValid()},
                        ),
                        const SizedBox(height: 10),
                        UnderlineInput(
                          controller: addr2InputController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          //onEditingComplete: () => {onLogin()},
                          placeholder: LanguageService.trans("address2"),
                          height: 52,
                          onChanged: (text) => {address2 = text, checkValid()},
                        ),
                        const SizedBox(height: 33),
                        H14(
                          text: LanguageService.trans("join_path"),
                          weight: FW.medium,
                          color: AppColor_Input_Title,
                        ),
                        const SizedBox(height: 10),
                        Selector(
                            selectedCategory: joinPath,
                            categoryList: pathList,
                            onSelect: (index) {
                              setState(() {
                                setState(() {
                                  joinPath = pathList[index];
                                });
                              });
                            },
                            hint: LanguageService.trans("input_join_path")),
                        // UnderlineInput(
                        //   controller: joinInputController,
                        //   keyboardType: TextInputType.text,
                        //   textInputAction: TextInputAction.next,
                        //   onEditingComplete: () => node.nextFocus(),
                        //   height: 30,
                        //   placeholder: LanguageService.trans("input_join_path"),
                        // ),
                        const SizedBox(height: 33),
                        H14(
                          text: LanguageService.trans("RefferID"),
                          weight: FW.medium,
                          color: AppColor_Input_Title,
                        ),
                        const SizedBox(height: 10),
                        UnderlineInput(
                          controller: referInputController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            // widget.isEdit ? onChangeProfile()
                            //     : Navigator.push(context, SlideRightTransRoute(builder: (context) => SignupUsePage(
                            //     email, pwd, name, getDateFormatString(birthday!, "yyyy-MM-dd"), phone, joinPath, referId, zipCode, address1, address2, target, gPushKey, widget.signupType
                            // )));
                          },
                          placeholder: LanguageService.trans("input_email_optional"),
                          onChanged: (text) {
                            referId = text;
                            checkValid();
                          },
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  // 추천인 문구
                  // Visibility(
                  //     visible: !widget.isEdit,
                  //     child: Container(
                  //       margin: const EdgeInsets.only(top: 24),
                  //       color: AppColor_Primary_Disable,
                  //       height: 50,
                  //       width: double.infinity,
                  //       //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  //       padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  //       child: SubstringHighlight(
                  //         text: LanguageService.trans("signup_hints"),
                  //         term: LanguageService.trans("signup_hints_1"),
                  //         textStyle: AppTextStyle.PD(
                  //           AppColor_Primary,
                  //           14,
                  //           weight: FW.medium,
                  //         ),
                  //         textStyleHighlight: AppTextStyle.PD(
                  //           AppColor_Primary,
                  //           14,
                  //           weight: FW.bold,
                  //         ),
                  //         textAlign: TextAlign.left,
                  //       ),
                  //     )),
                  const SizedBox(height: 55),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainTextButton(
                      text: widget.isEdit
                          ? LanguageService.trans("to_save")
                          : LanguageService.trans("getting_started"),
                      backgroundColor: AppColor_Primary,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                      //width: 360,
                      height: 58,
                      disable: !isValid,
                      disableBackground: !isValid
                          ? AppColor_Primary_Disable
                          : Colors.transparent,
                      onPressed: () {
                        if (!isValid) return;
                        widget.isEdit
                            ? onChangeProfile()
                            : Navigator.push(
                                context,
                                SlideRightTransRoute(
                                    builder: (context) => SignupUsePage(
                                        email: email,
                                        pwd: pwd,
                                        name: name,
                                        birthday: getDateFormatString(
                                            birthday!, "yyyy-MM-dd"),
                                        phone: phone,
                                        joinPath: joinPath,
                                        referId: referId,
                                        zipCode: zipCode,
                                        address1: address1,
                                        address2: address2,
                                        target: target,
                                        gPushKey: gPushKey,
                                        signupType: widget.signupType)));
                      },
                    ),
                  ),
                  Visibility(
                    visible: widget.isEdit,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: InkWell(
                            onTap: onWithdraw,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: H14(
                                text: LanguageService.trans("withdraw"),
                                color: AppColor_GrayText,
                                weight: FW.medium,
                              ),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 55),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
