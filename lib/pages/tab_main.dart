import 'dart:async';
import 'dart:io';

import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/fcm.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/bloodtest/bloodtest_complete.dart';
import 'package:decapet/pages/components/h13.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/home/homepage.dart';
import 'package:decapet/pages/hospital/find_hospital.dart';
import 'package:decapet/pages/mypage/my_point.dart';
import 'package:decapet/pages/mypage/mypage.dart';
import 'package:decapet/pages/review/review_write.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'alarm/alarm.dart';
import 'alarm/alarm.dart';
import 'base/page_layout.dart';

//import 'home/home_fragment.dart';
//import 'intro/intro.dart';
//import 'monitoring/monitoring_fragment.dart';

class TabMainPage extends StatefulWidget {
  @override
  TabMainPageState createState() => TabMainPageState();
}

class TabMainPageState extends BaseState<TabMainPage> with TickerProviderStateMixin {
  int backButtonTimestamp = 0;
  MainTab currentTab = MainTab.home;
  String title = "";
  late TabController tabController;

  void changeTab(MainTab tab) {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }

    setState(() {
      currentTab = tab;
      tabController.index = tab.index;
    });

    getAppInfo();
  }

  void goAlarmPage() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => AlarmPage()));
  }

  void getAppInfo() {
    showLoading();
    try {
      api.appInfo(user.info.access_token).then((res) {
        if (res.result == 0) {
          hideLoading();
          setState(() {
            user.info.alarm_cnt = res.data!.alarm_cnt;
            user.info.my_point = res.data!.my_point;
            user.info.pet_cnt = res.data!.pet_cnt;
            user.info.reservation_cnt = res.data!.reserve_cnt;
            user.info.reserve_past_cnt = res.data!.reserve_past_cnt;
            user.setInfo(user.info);
          });
        } else {
          hideLoading();
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void goMyPointPage() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => MyPointPage()));
  }

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - backButtonTimestamp < 2000) {
      exit(0);
    } else {
      showToast(LanguageService.trans('press_twice_to_exit'));
    }
    backButtonTimestamp = now;
    return false;
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      changeTab(MainTab.values[tabController.index]);
    });

    setupFcmListener(_recvMessage, _clickMessage);

    event.on<pointReview>().listen((event) {
      if (mounted) {
        changeTab(MainTab.review_write);
      }
    });
  }

  void _recvMessage(Map<String, dynamic> data) {
    // if (data['type'] == 'chat' || data['type'] == 'chatting_add' || data['type'] == 'purchase') {
    //   getIt<EventBus>().fire(ChatChanged(data));
    // }
    print(data);
    String _type = data['type'];
    showToast(_type);
    if (_type == "reservation") {
      //event.fire(payFinish());
      Navigator.push(
        context,
        SlideRightTransRoute(
          builder: (context) => BloodTestAppCompletePage(animalType: "dog", reservationId: ""),
        ),
      );
    }
  }

  void _clickMessage(Map<String, dynamic> data) {
    print(data);
    showToast("22222");
    String _type = data['type'];
    print(_type);
    // switch (_type) {
    //   case "community_added":
    //     String uid = data["uid"];
    //     if (uid == "") {
    //       return;
    //     }
    //     Navigator.push(context, SlideRightTransRoute(builder: (context) => CommunityDetailPage(uid: uid)));
    //     break;
    //   case "reply_added":
    //     String uid = data["uid"];
    //     if (uid == "") {
    //       return;
    //     }
    //     Navigator.push(context, SlideRightTransRoute(builder: (context) => CommunityDetailPage(uid: uid)));
    //     break;
    //   case "comment_added":
    //     String uid = data["uid"];
    //     if (uid == "") {
    //       return;
    //     }
    //     Navigator.push(context, SlideRightTransRoute(builder: (context) => CommunityDetailPage(uid: uid)));
    //     break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      isAvoidResize: false,
      onBack: onBackPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          child: Image.asset('assets/ic_alarm.png', width: 24),
                          onTap: () {
                            goAlarmPage();
                          },
                        ),
                        Visibility(
                          visible: user.info.alarm_cnt > 0,
                          child: const Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              radius: 2.5,
                              backgroundColor: AppColor_Red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Image.asset('assets/ic_main_logo.png', height: 20),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: MainTextButton(
                  text: formatAmount(user.info.my_point) + LanguageService.trans('p'),
                  style: AppTextStyle.PD(Colors.blue, 14, weight: FW.bold),
                  radius: 15,
                  width: 80,
                  height: 30,
                  showBorder: true,
                  borderColor: Colors.lightBlueAccent,
                  backgroundColor: AppColor_Light_Blue,
                  onPressed: () {
                    goMyPointPage();
                  },
                ),
              )
            ]),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: HomePage(),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ReviewWritePage(),
                ),
                Container(
                  alignment: Alignment.center,
                  child: FindHospital(),
                ),
                Container(
                  alignment: Alignment.center,
                  child: MyPage(),
                ),
              ],
            ),
          ),
          //const Divider(),
          Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.fromLTRB(55, 25, 55, 0),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)), boxShadow: [
              BoxShadow(
                color: AppColor_Gray,
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  5.0, // Move to right 10  horizontally
                  5.0, // Move to bottom 5 Vertically
                ),
              )
            ]),
            child: Stack(
              children: [
                Align(
                    // padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    alignment: Alignment.bottomLeft,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(
                        child: InkWell(
                            onTap: () {
                              changeTab(MainTab.home);
                            },
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                              Image.asset(currentTab == MainTab.home ? "assets/ic_home_on.png" : "assets/ic_home_off.png", width: 20),
                              const SizedBox(height: 10),
                              H13(
                                text: LanguageService.trans('home'),
                                color: currentTab == MainTab.home ? AppColor_Primary : AppColor_Tab_Unselected,
                                weight: FW.medium,
                              )
                            ])),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            changeTab(MainTab.review_write);
                          },
                          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Image.asset(currentTab == MainTab.review_write ? "assets/ic_review_on.png" : "assets/ic_review_off.png", width: 20),
                            const SizedBox(height: 10),
                            H13(
                              text: LanguageService.trans('review_write'),
                              color: currentTab == MainTab.review_write ? AppColor_Primary : AppColor_Tab_Unselected,
                              weight: FW.medium,
                            )
                          ]),
                        ),
                      ),
                      Container(
                        child: InkWell(
                            onTap: () {
                              //faqFromSide = false;
                              changeTab(MainTab.find_hospital);
                            },
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                              Image.asset(currentTab == MainTab.find_hospital ? "assets/ic_find_on.png" : "assets/ic_find_off.png", width: 20),
                              const SizedBox(height: 10),
                              H13(
                                text: LanguageService.trans('find_hospital'),
                                color: currentTab == MainTab.find_hospital ? AppColor_Primary : AppColor_Tab_Unselected,
                                weight: FW.medium,
                              )
                            ])),
                      ),
                      Container(
                        child: InkWell(
                            onTap: () {
                              changeTab(MainTab.my_page);
                            },
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                              Image.asset(currentTab == MainTab.my_page ? "assets/ic_mypage_on.png" : "assets/ic_mypage_off.png", width: 20),
                              const SizedBox(height: 10),
                              H13(
                                text: LanguageService.trans('my_page'),
                                color: currentTab == MainTab.my_page ? AppColor_Primary : AppColor_Tab_Unselected,
                                weight: FW.medium,
                              )
                            ])),
                      ),
                    ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
