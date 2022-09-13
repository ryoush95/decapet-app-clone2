import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/custom_button_2.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../components/h14.dart';

class ReviewItem extends StatefulWidget {
  ReviewItem({
    Key? key,
    required this.item,
    required this.onMore,
    required this.onLikeHospital,
    required this.onLikeReview,
  }) : super(key: key);
  final ReviewDto item;
  final onMore;
  final onLikeHospital;
  final onLikeReview;

  @override
  ReviewItemState createState() => ReviewItemState();
}

class ReviewItemState extends BaseState<ReviewItem> {
  bool showDetail = false;
  late Color bg_color = Colors.blue;

  List<Widget> _feelings = [];

  @override
  void initState() {
    super.initState();

    initFeelings();
  }

  void initFeelings() {
    feelingList.clear();
    feelings.clear();

    try {
      api.feeling_list(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            feelings = value.data!.list;

            feelingList.add(Feeling(image: "assets/ic_review1.png", feeling: feelings[0]));
            feelingList.add(Feeling(image: "assets/ic_review2.png", feeling: feelings[1]));
            feelingList.add(Feeling(image: "assets/ic_review3.png", feeling: feelings[2]));
            feelingList.add(Feeling(image: "assets/ic_review4.png", feeling: feelings[3]));
            feelingList.add(Feeling(image: "assets/ic_review5.png", feeling: feelings[4]));
            feelingList.add(Feeling(image: "assets/ic_review6.png", feeling: feelings[5]));
            feelingList.add(Feeling(image: "assets/ic_review7.png", feeling: feelings[6]));
            feelingList.add(Feeling(image: "assets/ic_review8.png", feeling: feelings[7]));
            feelingList.add(Feeling(image: "assets/ic_review9.png", feeling: feelings[8]));
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

  Future<bool> onBackPressed() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    String purposeImage = "";
    String purpose = "";
    if (widget.item.purpose.split(",").first == "diagnosis") {
      bg_color = Colors.blue;
      purpose = LanguageService.trans("diagnosis");
      purposeImage = "assets/inventory_black_24dp.png";
    } else if (widget.item.purpose.split(",").first == "supplies") {
      bg_color = Colors.indigoAccent;
      purpose = LanguageService.trans("supplies");
      purposeImage = "assets/local_mall_black_24dp.png";
    } else if (widget.item.purpose.split(",").first == "hotel") {
      bg_color = Colors.yellow;
      purposeImage = "assets/luggage_black_24dp.png";
      purpose = LanguageService.trans("hotel");
    } else if (widget.item.purpose.split(",").first == "beauty") {
      bg_color = Colors.deepPurple;
      purpose = LanguageService.trans("beauty");
      purposeImage = "assets/pets_black_24dp.png";
    }

    _feelings.clear();
    if (widget.item.feelings.isNotEmpty) {
      widget.item.feelings.split(",").forEach((item) {
        if (feelings.contains(item)) {
          int index = feelings.indexOf(item);
          _feelings.add(
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: AppColor_Light_Blue, borderRadius: BorderRadius.circular(10.0), border: Border.all(color: AppColor_Primary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    feelingList[index].image,
                    width: 25,
                  ),
                  SizedBox(width: 10),
                  Flexible(flex: 1, child: Text(feelingList[index].feeling, style: AppTextStyle.PD(AppColor_Primary, 14.0, weight: FW.bold)))
                ],
              ),
            ),
          );
        } else {
          _feelings.add(
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: AppColor_Light_Blue, borderRadius: BorderRadius.circular(10.0), border: Border.all(color: AppColor_Primary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.asset('assets/character_smile2.png', width: 25),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Image.asset('assets/ic_red_heart_on.png', width: 10, height: 10),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Flexible(flex: 1, child: Text(item, style: AppTextStyle.PD(AppColor_Primary, 14.0, weight: FW.bold)))
                ],
              ),
            ),
          );
        }
      });
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 37),
          Container(
              decoration: BoxDecoration(
                color: AppColor_White,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 19,
                      ),
                      Container(
                        //color: bg_color,
                        clipBehavior: Clip.antiAlias,
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(color: bg_color, borderRadius: BorderRadius.all(Radius.circular(22))),
                        child: Center(child: Image.asset(purposeImage, color: Colors.white, width: 20, height: 20, fit: BoxFit.contain)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //padding
                          Container(
                            padding: const EdgeInsets.only(left: 11),
                            child: H12(
                              text: purpose,
                              weight: FW.bold,
                              align: TextAlign.start,
                              color: AppColor_Primary,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 11),
                            child: H14(
                              text: LanguageService.trans(widget.item.hospital_name),
                              weight: FW.semi_bold,
                              align: TextAlign.left,
                              color: AppColor_BlackText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      height: 0.2,
                      decoration: BoxDecoration(
                        //border: Border.all(color: AppColor_Red, width: 1.0),
                        color: AppColor_GrayText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 19),
                    child: H14(
                      // text: sprintf(LanguageService.trans("visited_at"), [getDateFormatString(DateTime.parse(widget.item.created_at), "HH:mm"), getDateFormatString(DateTime.parse(widget.item.created_at), "EEEE, MMMM d")]),
                      text: getDateFormatString(DateTime.parse(widget.item.created_at), "MMMEd") + " " + getDateFormatString(DateTime.parse(widget.item.created_at), "HH:mm") + " " + LanguageService.trans("visited_date1"),
                      weight: FW.medium,
                      align: TextAlign.left,
                      color: AppColor_BlackText,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              )),
          SizedBox(height: 20),
          Row(
            children: [
              //SizedBox(width: 24,),
              Container(
                //width: 84,
                height: 24,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: widget.item.status == "confirmed" ? AppColor_Primary : AppColor_Black_Disable),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 7),
                    Image.asset('assets/ic_white_check.png', width: 14, height: 14, alignment: Alignment.centerLeft, color: AppColor_White),
                    const SizedBox(width: 5),
                    H14(text: LanguageService.trans("receipt"), color: AppColor_White, weight: FW.semi_bold, align: TextAlign.left, maxLine: 2),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                width: 24,
                height: 24,
                //padding: const EdgeInsets.symmetric(horizontal: 45),
                child: CustomButton2(
                  backgroundColor: Colors.grey,
                  width: 40,
                  height: 24,
                  onPressed: () {
                    if (widget.item.user_id == user.info.id) {
                      widget.onMore();
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: widget.onLikeHospital,
            child: Row(
              children: [
                //SizedBox(width: 24,),
                Image.asset(
                  widget.item.favourite_yn == "y" ? 'assets/ic_like_on.png' : 'assets/ic_like_off.png',
                  width: 24,
                  height: 24,
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  width: 7,
                ),
                H14(text: LanguageService.trans("I like this hospital"), color: Colors.blue, weight: FW.bold, align: TextAlign.center, maxLine: 2),
              ],
            ),
          ),
          SizedBox(height: 10),
          ReadMoreText(
            widget.item.description,
            trimLines: 4,
            style: AppTextStyle.PD(Colors.black54, 16, height: 1.2),
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: LanguageService.trans("more"),
            trimExpandedText: 'less',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor_Primary),
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor_Primary),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(width: 25,),
              Row(
                children: [
                  H14(text: makeStr(widget.item.user_name) + " ", color: AppColor_36383C, weight: FW.bold, align: TextAlign.center, maxLine: 2),
                  H14(text: LanguageService.trans("nim"), color: AppColor_36383C, weight: FW.medium, align: TextAlign.center, maxLine: 2),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColor_Gray)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    H14(text: LanguageService.trans("it helped"), color: Colors.black87, weight: FW.semi_bold, align: TextAlign.center, maxLine: 2),
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: widget.onLikeReview,
                      child: Row(
                        children: [
                          Image.asset(
                            widget.item.like_yn == "y" ? 'assets/ic_red_heart_on.png' : 'assets/ic_red_heart_off.png',
                            width: 24,
                            height: 24,
                            alignment: Alignment.centerLeft,
                          ),
                          SizedBox(width: 5),
                          H14(text: widget.item.like_cnt.toString(), color: Colors.black87, weight: FW.semi_bold, align: TextAlign.center, maxLine: 2),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Visibility(
            visible: showDetail,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  //padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: H14(text: LanguageService.trans("like_this"), color: Colors.black87, weight: FW.semi_bold, align: TextAlign.left, maxLine: 2),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: _feelings,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                showDetail = !showDetail;
              });
            },
            child: Center(
              child: Container(
                height: 30,
                transform: Matrix4.translationValues(0, showDetail ? 25 : 0, 0),
                child: Container(
                  transform: Matrix4.rotationX(showDetail ? 3.14 : 0),
                  child: Image.asset(
                    'assets/ic_down.png',
                    width: 20,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
