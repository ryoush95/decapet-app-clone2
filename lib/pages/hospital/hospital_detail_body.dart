import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/hospital_detail_item_dto.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/models/dto/review_info_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/outline_input.dart';
import 'package:decapet/pages/home/write_receipt_review.dart';
import 'package:decapet/pages/items/hospital_verified_item.dart';
import 'package:flutter/material.dart';

import '../items/hospital_detail_item.dart';

class HospitalDetailBodyPage extends StatefulWidget {
  int hospitalID;
  String hospitalName;
  final onBackPressed;

  HospitalDetailBodyPage({Key? key, required this.hospitalID, required this.hospitalName, this.onBackPressed}) : super(key: key);

  @override
  HospitalDetailBodyPageState createState() => HospitalDetailBodyPageState();
}

class HospitalDetailBodyPageState extends BaseState<HospitalDetailBodyPage> {
  List<HospitalDetailItemDto> items = [];
  int itemCount = 0;
  bool isRegistered = false;
  var nameInputController = TextEditingController();
  String hospital_name = "";
  bool isValid = false;

  ScrollController scrollController = ScrollController();
  List<ReviewDto> reviewList = [];
  ReviewInfoDto reviewInfo = ReviewInfoDto();
  bool isLast = false;
  int page = 0;
  bool viewFeelingsMore = false;
  String diagCnt = '';
  String supplyCnt = '';
  String hotelCnt = '';
  String beautyCnt = '';
  String orderType = 'recent';
  String purpose = '';

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(onScroll);
    loadReviewList();
    loadReviewInfo();
  }

  Future<void> refresh() async {
    page = 0;
    loadReviewList();
  }

  void onScroll() {
    if (!isLoading) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadReviewList();
      }
    }
  }

  void loadReviewList() {
    showLoading();
    try {
      api.review_list(user.info.access_token, page, widget.hospitalID, nameInputController.text, purpose, orderType, 0).then((res) {
        if (res.result == 0) {
          hideLoading();

          if (page == 0) {
            reviewList.clear();
          }
          setState(() {
            reviewList.addAll(res.data!.list);
          });

          isLast = res.data!.isLast;
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

  void changeOrderType(type) {
    setState(() {
      orderType = type;
    });
    page = 0;
    loadReviewList();
  }

  void changePurpose(type) {
    setState(() {
      purpose = type;
    });
    page = 0;
    loadReviewList();
  }

  void loadReviewInfo() {
    showLoading();
    try {
      api.review_info(user.info.access_token, widget.hospitalID).then((res) {
        if (res.result == 0) {
          hideLoading();
          setState(() {
            reviewInfo = res.data!;
            loadHospitalDetailBody();
            itemCount = viewFeelingsMore ? 9 : 4;
            diagCnt = reviewInfo.purpose_cnts.split(',')[0];
            supplyCnt = reviewInfo.purpose_cnts.split(',')[0];
            hotelCnt = reviewInfo.purpose_cnts.split(',')[0];
            beautyCnt = reviewInfo.purpose_cnts.split(',')[0];
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

  Future<bool> onBackPressed() async {
    Navigator.pop(context);
    return true;
  }

  void onWriteReview() {
    Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => WriteReceiptReviewPage(
                  medicalUid: 0,
                  hospitalName: widget.hospitalName,
                  hospitalUid: widget.hospitalID,
                  reviewId: 0,
                )));
  }

  void onSearch() {
    page = 0;
    FocusScope.of(context).requestFocus(FocusNode());
    loadReviewList();
  }

  void onLikeReview(index) {
    if (reviewList[index].user_id == user.info.id) {
      return;
    }

    String likeYn = reviewList[index].like_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.likeReview(user.info.access_token, reviewList[index].id, likeYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            reviewList[index].like_yn = likeYn;
            if (likeYn == "y") {
              reviewList[index].like_cnt = reviewList[index].like_cnt + 1;
            } else {
              reviewList[index].like_cnt = reviewList[index].like_cnt - 1;
            }
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

  void loadHospitalDetailBody() {
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review1.png",
      content: LanguageService.trans("feeling_1"),
      percent: reviewInfo.feeling_percents.split(',')[0] + '%',
    ));
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review2.png",
      content: LanguageService.trans("feeling_2"),
      percent: reviewInfo.feeling_percents.split(',')[1] + '%',
    ));
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review3.png",
      content: LanguageService.trans("feeling_3"),
      percent: reviewInfo.feeling_percents.split(',')[2] + '%',
    ));
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review4.png",
      content: LanguageService.trans("feeling_4"),
      percent: reviewInfo.feeling_percents.split(',')[3] + '%',
    ));
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review5.png",
      content: LanguageService.trans("feeling_5"),
      percent: reviewInfo.feeling_percents.split(',')[4] + '%',
    ));
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review6.png",
      content: LanguageService.trans("feeling_6"),
      percent: reviewInfo.feeling_percents.split(',')[5] + '%',
    ));
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review7.png",
      content: LanguageService.trans("feeling_7"),
      percent: reviewInfo.feeling_percents.split(',')[6] + '%',
    ));
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review8.png",
      content: LanguageService.trans("feeling_8"),
      percent: reviewInfo.feeling_percents.split(',')[7] + '%',
    ));
    items.add(HospitalDetailItemDto(
      imgPath: "assets/ic_review9.png",
      content: LanguageService.trans("feeling_9"),
      percent: reviewInfo.feeling_percents.split(',')[8] + '%',
    ));
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          // height: 210,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  H18(
                    text: LanguageService.trans("like_this"),
                    weight: FW.bold,
                    height: 1.5,
                  ),
                  MainTextButton(
                    width: 82,
                    height: 34,
                    text: LanguageService.trans("write_a"),
                    backgroundColor: Colors.black87,
                    style: AppTextStyle.PD(Colors.white, 14, weight: FW.medium),
                    radius: 6.0,
                    onPressed: () {
                      onWriteReview();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  H16(
                    text: reviewInfo.total_user_cnt.toString(),
                    weight: FW.bold,
                    color: AppColor_Primary,
                    height: 1.5,
                  ),
                  H16(
                    text: LanguageService.trans("hu"),
                    weight: FW.medium,
                    color: AppColor_36383C,
                    height: 1.5,
                  ),
                  const SizedBox(width: 6),
                  H16(
                    text: "(" + reviewInfo.reviewer_cnt.toString() + LanguageService.trans("attend") + ")",
                    weight: FW.medium,
                    color: AppColor_GrayText,
                    height: 1.5,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return HospitalDetailItem(item: items[index]);
                  },
                  itemCount: itemCount),
            ],
          ),
        ),
        const SizedBox(height: 22),
        InkWell(
          child: Center(
            child: Container(
              height: 30,
              transform: Matrix4.translationValues(0, viewFeelingsMore ? 25 : 0, 0),
              child: Container(
                transform: Matrix4.rotationX(viewFeelingsMore ? 3.14 : 0),
                child: Image.asset(
                  'assets/ic_blue_down1.png',
                  width: 15,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              viewFeelingsMore = !viewFeelingsMore;
              itemCount = viewFeelingsMore ? 9 : 4;
            });
          },
        ),
        const SizedBox(height: 30),
        Container(
          width: double.maxFinite,
          height: 71,
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(5),
              color: AppColor_Light_Blue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H14(
                text: LanguageService.trans("receipt_verify_review"),
                weight: FW.medium,
                height: 1.5,
                color: Colors.blue,
                align: TextAlign.left,
                maxLine: 2,
              ),
              Image.asset("assets/ic_blue_right.png", width: 15, height: 15),
            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 48,
          margin: const EdgeInsets.fromLTRB(24, 32, 24, 16),
          child: Stack(
            children: [
              OutlineInput(
                controller: nameInputController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onEditingComplete: onSearch,
                placeholder: LanguageService.trans("search_by_key"),
                onChanged: (text) => {hospital_name = text},
                // imagePath: "assets/search_black_24dp.png",
              ),
              Positioned(
                right: 15,
                top: 7,
                child: InkWell(
                  onTap: onSearch,
                  child: Image.asset("assets/search_black_24dp.png", width: 25),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 24),
                MainTextButton(
                  width: 42,
                  height: 30,
                  text: LanguageService.trans("all"),
                  backgroundColor: purpose.isEmpty ? AppColor_Light_Gray : AppColor_Light_Blue,
                  style: AppTextStyle.PD(purpose.isEmpty ? Colors.blue : Colors.black, 14, weight: FW.regular),
                  showBorder: true,
                  borderColor: purpose.isEmpty ? AppColor_Primary : AppColor_Gray,
                  radius: 15.0,
                  onPressed: () {
                    changePurpose("");
                  },
                ),
                const SizedBox(width: 8),
                MainTextButton(
                  width: 60,
                  height: 30,
                  text: LanguageService.trans("diagnosis") + " " + diagCnt,
                  backgroundColor: purpose == "diagnosis" ? AppColor_Light_Gray : AppColor_White,
                  style: AppTextStyle.PD(purpose == "diagnosis" ? Colors.blue : Colors.black, 14, weight: FW.regular),
                  showBorder: true,
                  borderColor: purpose == "diagnosis" ? AppColor_Primary : AppColor_Gray,
                  radius: 15.0,
                  onPressed: () {
                    changePurpose("diagnosis");
                  },
                ),
                const SizedBox(width: 8),
                MainTextButton(
                  width: 60,
                  height: 30,
                  text: LanguageService.trans("supplies") + " " + supplyCnt,
                  backgroundColor: purpose == "supplies" ? AppColor_Light_Gray : AppColor_White,
                  style: AppTextStyle.PD(purpose == "supplies" ? Colors.blue : Colors.black, 14, weight: FW.regular),
                  showBorder: true,
                  borderColor: purpose == "supplies" ? AppColor_Primary : AppColor_Gray,
                  radius: 15.0,
                  onPressed: () {
                    changePurpose("supplies");
                  },
                ),
                const SizedBox(width: 8),
                MainTextButton(
                  width: 60,
                  height: 30,
                  text: LanguageService.trans("hotel") + " " + hotelCnt,
                  backgroundColor: purpose == "hotel" ? AppColor_Light_Gray : AppColor_White,
                  style: AppTextStyle.PD(purpose == "hotel" ? Colors.blue : Colors.black, 14, weight: FW.regular),
                  showBorder: true,
                  borderColor: purpose == "hotel" ? AppColor_Primary : AppColor_Gray,
                  radius: 15.0,
                  onPressed: () {
                    changePurpose("hotel");
                  },
                ),
                const SizedBox(width: 8),
                MainTextButton(
                  width: 60,
                  height: 30,
                  text: LanguageService.trans("beauty") + " " + beautyCnt,
                  backgroundColor: purpose == "beauty" ? AppColor_Light_Gray : AppColor_White,
                  style: AppTextStyle.PD(purpose == "beauty" ? Colors.blue : Colors.black, 14, weight: FW.regular),
                  showBorder: true,
                  borderColor: purpose == "beauty" ? AppColor_Primary : AppColor_Gray,
                  radius: 15.0,
                  onPressed: () {
                    changePurpose("beauty");
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          height: 5,
          color: AppColor_Divider,
        ),
        const SizedBox(height: 28),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: PopupMenuButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/ic_order.png", width: 20, height: 20),
                SizedBox(width: 10),
                H14(
                  text: LanguageService.trans(orderType),
                  weight: FW.semi_bold,
                  height: 1.5,
                  color: AppColor_GrayText,
                  align: TextAlign.left,
                ),
              ],
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                height: 30,
                onTap: () {
                  changeOrderType("recent");
                },
                child: H12(text: LanguageService.trans("recent"), color: AppColor_GrayText),
              ),
              PopupMenuItem(
                height: 30,
                onTap: () {
                  changeOrderType("like");
                },
                child: H12(text: LanguageService.trans("like"), color: AppColor_GrayText),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: 1,
          color: AppColor_Selector_Border,
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return HospitalVerifiedItem(
                item: reviewList[index],
                onLikeReview: () {
                  onLikeReview(index);
                },
              );
            },
            itemCount: reviewList.length),
        const SizedBox(height: 50),
      ],
    );
  }
}
