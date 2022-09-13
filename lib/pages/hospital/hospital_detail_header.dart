import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/hospital/hospital_info.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'hospital_detail.dart';
import 'hospital_reserve.dart';

class HospitalDetailHeader extends StatefulWidget {
  final HospitalDto item;

  const HospitalDetailHeader({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  HospitalDetailHeaderState createState() => HospitalDetailHeaderState();
}

class HospitalDetailHeaderState extends BaseState<HospitalDetailHeader> with TickerProviderStateMixin {
  int tabIndex = 0;
  bool IsexistImage = true;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      changeTab(tabController.index);
    });

    //tabController.index = faqFromSide ? 1 : 0;
  }

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  void changeTab(int tab) {
    setState(() {
      tabIndex = tab;
      tabController.index = tabIndex;
    });
  }

  void onReservation() {
    FocusScope.of(context).requestFocus(FocusNode());

    if (widget.item.reserve_yn == "n") {
      phoneCall();
    } else {
      Navigator.push(
        context,
        SlideRightTransRoute(
          builder: (context) => HospitalReserve(
            hospital: widget.item,
          ),
        ),
      );
    }
  }

  void onLikeHospital() {
    String favoriteYn = widget.item.like_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.setFavorite(user.info.access_token, widget.item.id, favoriteYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            widget.item.like_yn = favoriteYn;
          });
        } else {
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  Future<void> phoneCall() async {
    String url = "tel://" + widget.item.phone_number;
    String phone = widget.item.phone_number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = <String>[LanguageService.trans("Hospital_Info"), LanguageService.trans("review") + '(' + widget.item.review_cnt.toString() + ')'];
    return PageLayout(
        isAvoidResize: false,
        onBack: onBackPressed,
        isLoading: isLoading,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            child: Container(padding: const EdgeInsets.symmetric(horizontal: 20), child: Image.asset('assets/btn_back.png', width: 10)),
                            onTap: onBackPressed,
                          )),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: H18(text: widget.item.name, weight: FW.medium, maxLine: 2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: InkWell(
                            child: Image.asset(
                              widget.item.like_yn == 'y' ? "assets/ic_like_on.png" : "assets/ic_red_heart_off.png",
                              width: 20,
                            ),
                            onTap: onLikeHospital,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: _tabs.length, // This is the number of tabs.
                    child: Scaffold(
                      body: NestedScrollView(
                          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                            // These are the slivers that show up in the "outer" scroll view.
                            return <Widget>[
                              SliverOverlapAbsorber(
                                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                                sliver: SliverAppBar(
                                  // title: const Text('Books'), // This is the title in the app bar.
                                  pinned: false,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.transparent,
                                  expandedHeight: 244.0,
                                  flexibleSpace: Image.network(
                                    widget.item.image,
                                    fit: BoxFit.fill,
                                    height: 244,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ];
                          },
                          body: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTabHeaderItem(LanguageService.trans("Hospital_Info"), 0),
                                  _buildTabHeaderItem(LanguageService.trans("review") + '(' + widget.item.review_cnt.toString() + ')', 1),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: tabController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    HospitalInfo(item: widget.item),
                                    HospitalDetailPage(hospitalId: widget.item.id, hospitalName: widget.item.name),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MainTextButton(
                text: widget.item.reserve_yn == "n" ? LanguageService.trans("tel") : LanguageService.trans("do_reserve"),
                radius: 0,
                backgroundColor: widget.item.reserve_yn == "n" ? AppColor_Intro_Description : AppColor_Primary,
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.medium),
                width: double.infinity,
                height: 58,
                onPressed: onReservation,
              ),
            )
          ],
        ));
  }

  Widget _buildTabHeaderItem(String tabText, int step) {
    return InkWell(
      child: Container(
          width: (MediaQuery.of(context).size.width) / 2,
          color: Colors.white,
          height: 56,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: H14(text: tabText, color: tabIndex == step ? Colors.blue : AppColor_Tab_Unselected, weight: FW.medium, maxLine: 2),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: tabIndex == step ? 4 : 1,
                  color: tabIndex == step ? Colors.blue : AppColor_Selector_Border,
                ),
              )
            ],
          )),
      onTap: () {
        changeTab(step);
      },
    );
  }
}
