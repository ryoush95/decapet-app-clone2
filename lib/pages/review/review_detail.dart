import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/custom_button_2.dart';
import 'package:decapet/pages/components/custom_button_3.dart';
import 'package:decapet/pages/components/custom_button_4.dart';
import 'package:decapet/pages/components/custom_button_5.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/home/write_receipt_review.dart';
import 'package:decapet/pages/review/photo_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ReviewDetailPage extends StatefulWidget {
  ReviewDto item;

  ReviewDetailPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  ReviewDetailPageState createState() => ReviewDetailPageState();
}

class ReviewDetailPageState extends BaseState<ReviewDetailPage> {
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
    Navigator.of(context).pop();
    return false;
  }

  void onLikeHospital() {
    String favoriteYn = widget.item.favourite_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.setFavorite(user.info.access_token, widget.item.hospital_id, favoriteYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          event.fire(LikeHospital(widget.item.hospital_id, favoriteYn));
          setState(() {
            widget.item.favourite_yn = favoriteYn;
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

  void onLikeReview() {
    if (widget.item.user_id == user.info.id) {
      return;
    }

    String likeYn = widget.item.like_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.likeReview(user.info.access_token, widget.item.id, likeYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            widget.item.like_yn = likeYn;
            if (likeYn == "y") {
              widget.item.like_cnt = widget.item.like_cnt + 1;
            } else {
              widget.item.like_cnt = widget.item.like_cnt - 1;
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

  void onMore() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)), color: Colors.transparent),
          child: Column(
            children: [
              CustomButton3(
                onPressed: () {
                  Navigator.of(context).pop();
                  onEdit();
                },
                text: LanguageService.trans('to_edit'),
                fontcolor: Colors.blue,
              ),
              Container(
                height: 1,
                color: AppColor_Gray,
              ),
              CustomButton4(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDelete();
                },
                text: LanguageService.trans('delete'),
                fontcolor: Colors.red,
              ),
              const SizedBox(height: 5),
              CustomButton5(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: LanguageService.trans('cancel'),
                fontcolor: Colors.blue,
              )
            ],
          ),
        );
      },
    );
  }

  void onEdit() {
    Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => WriteReceiptReviewPage(
                  medicalUid: widget.item.medical_record_id,
                  hospitalName: widget.item.hospital_name,
                  hospitalUid: widget.item.hospital_id,
                  reviewId: widget.item.id,
                )));
  }

  void onDelete() {
    showLoading();
    try {
      api.review_delete(user.info.access_token, widget.item.id).then((res) {
        hideLoading();
        if (res.result == 0) {
          event.fire(ReviewDeleted(widget.item.id));
          Navigator.of(context).pop();
        } else {
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Flexible(flex: 1, child: Text(feelingList[index].feeling, style: AppTextStyle.PD(AppColor_Primary, 16.0, weight: FW.bold)))
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
                        child: Image.asset('assets/ic_like_on.png', width: 10, height: 10),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Flexible(flex: 1, child: Text(item, style: AppTextStyle.PD(AppColor_Primary, 16.0, weight: FW.bold)))
                ],
              ),
            ),
          );
        }
      });
    }
    return PageLayout(
        isLoading: isLoading,
        child: Column(children: [
          SimpleHeader(
            title: LanguageService.trans('Review Detail'),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
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
                                onMore();
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
                      onTap: onLikeHospital,
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
                          H16(text: LanguageService.trans("I like this hospital"), color: Colors.blue, weight: FW.semi_bold, align: TextAlign.center, maxLine: 2),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 0,
                      ),
                      child: Text(
                        widget.item.description,
                        style: AppTextStyle.PD(Colors.black, 16, height: 1.2, weight: FW.regular),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, SlideRightTransRoute(builder: (context) => PhotoViewPage(img: widget.item.review_images.split(",")[index])));
                                },
                                child: ExtendedImage(
                                  height: 150,
                                  width: 150,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(const Radius.circular(5)),
                                  image: NetworkImage(widget.item.review_images.split(",")[index]),
                                ),
                              ),
                            );
                          },
                          itemCount: widget.item.review_images.split(",").length),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //SizedBox(width: 25,),
                        H16(text: makeStr(widget.item.user_name) + " " + LanguageService.trans("nim"), color: Colors.black87, weight: FW.semi_bold, align: TextAlign.center, maxLine: 2),
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColor_Gray)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              H16(text: LanguageService.trans("it helped"), color: Colors.black87, weight: FW.semi_bold, align: TextAlign.center, maxLine: 2),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: onLikeReview,
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
                    SizedBox(height: 30),
                    Container(
                      //padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: H16(text: LanguageService.trans("like_this"), color: Colors.black87, weight: FW.semi_bold, align: TextAlign.left, maxLine: 2),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: _feelings,
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
