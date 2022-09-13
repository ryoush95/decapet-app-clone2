import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/user_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/hospital/favor_hospital.dart';
import 'package:decapet/pages/intro/first.dart';
import 'package:decapet/pages/items/list_item.dart';
import 'package:decapet/pages/mypage/my_info.dart';
import 'package:decapet/pages/pet/pet_list.dart';
import 'package:decapet/pages/reserve/reserve_history.dart';
import 'package:decapet/pages/review/review_manage.dart';
import 'package:decapet/pages/setting/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_point.dart';

class MyPage extends StatefulWidget {
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends BaseState<MyPage> {
  @override
  void initState() {
    super.initState();

    event.on<ReserveCancelled>().listen((event) {
      if (mounted) {
        setState(() {
          user.info.reservation_cnt = user.info.reservation_cnt - 1;
        });
      }
    });

    event.on<ReserveCancelled>().listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        isLoading: isLoading,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H14(
                            text: LanguageService.trans('mypage_welcome'),
                            weight: FW.medium,
                            color: AppColor_GrayText,
                          ),
                          const SizedBox(height: 15),
                          H20(
                            text: sprintf("%s %s", [user.info.name, LanguageService.trans('nim')]),
                            align: TextAlign.start,
                            weight: FW.bold,
                            color: AppColor_BlackText,
                            maxLine: 2,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: gStartInfo.stable,
                      child: InkWell(
                        onTap: onMyInfo,
                        child: ListItem(title: LanguageService.trans('mypage_myinfo'), icon_path: "assets/person_black_24dp.png", font_size: 16, font_style: FW.medium, badge: ""),
                      ),
                    ),
                    InkWell(
                      onTap: onGoMyPoint,
                      child: Observer(builder: (_) => ListItem(title: LanguageService.trans('mypage_mypoint'), icon_path: "assets/savings_black_24dp1.png", font_size: 16, font_style: FW.medium, badge: formatAmount(user.info.my_point) + " " + LanguageService.trans("p"))),
                    ),
                    InkWell(
                      onTap: onGoPetList,
                      child: Observer(builder: (_) => ListItem(title: LanguageService.trans('mypage_petlist'), icon_path: "assets/pets_black_24dp1.png", font_size: 16, font_style: FW.medium, badge: user.info.pet_cnt.toString())),
                    ),
                    InkWell(
                      onTap: onGoReservHistory,
                      child: Observer(builder: (_) => ListItem(title: LanguageService.trans('mypage_reservationhistory'), icon_path: "assets/inventory_black_24dp.png", font_size: 16, font_style: FW.medium, badge: user.info.reservation_cnt.toString())),
                    ),
                    InkWell(
                      onTap: onGoReviewManage,
                      child: ListItem(title: LanguageService.trans('mypage_reviewmanagement'), icon_path: "assets/receipt_long_black_24dp.png", font_size: 16, font_style: FW.medium, badge: ""),
                    ),
                    InkWell(
                      onTap: onGoFavHospital,
                      child: ListItem(title: LanguageService.trans('mypage_favoritehospital'), icon_path: "assets/favorite_black_24dp-2.png", font_size: 16, font_style: FW.medium, badge: ""),
                    ),
                    InkWell(
                      onTap: onGoSetting,
                      child: ListItem(title: LanguageService.trans('mypage_appsettings'), icon_path: "assets/settings_black_24dp.png", font_size: 16, font_style: FW.medium, badge: ""),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 25, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H20(
                            text: LanguageService.trans('mypage_servicecenter'),
                            weight: FW.bold,
                            color: AppColor_BlackText,
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              launch("mailto:" + gStartInfo.email);
                            },
                            child: H14(
                              text: gStartInfo.email,
                              align: TextAlign.start,
                              weight: FW.semi_bold,
                              color: AppColor_GrayText,
                              maxLine: 2,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 25, 20),
                      child: Center(
                        child: InkWell(
                            onTap: onLogout,
                            child: H14(
                              text: LanguageService.trans('mypage_logout'),
                              weight: FW.medium,
                              color: AppColor_GrayText,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void onMyInfo() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => MyInfoPage()));
  }

  void onGoSetting() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => AppSettingPage()));
  }

  void onGoMyPoint() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => MyPointPage()));
  }

  void onGoPetList() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => PetListPage()));
  }

  void onGoReservHistory() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReserveHistoryPage()));
  }

  void onGoReviewManage() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReviewManagePage()));
  }

  void onGoFavHospital() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => FavorHospitalPage()));
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
}
