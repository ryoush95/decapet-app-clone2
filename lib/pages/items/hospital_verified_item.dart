import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/review/review_detail.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class HospitalVerifiedItem extends StatefulWidget {
  final ReviewDto item;
  final onLikeReview;

  HospitalVerifiedItem({
    Key? key,
    required this.item,
    required this.onLikeReview,
  }) : super(key: key);

  @override
  HospitalVerifiedItemState createState() => HospitalVerifiedItemState();
}

class HospitalVerifiedItemState extends BaseState<HospitalVerifiedItem> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void goReviewDetail() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReviewDetailPage(item: widget.item)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: goReviewDetail,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: widget.item.status == "testing" ? Color(0xFFEDEEEF) : AppColor_Primary,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Image.asset(widget.item.status == 'testing' ? "assets/ic_white_check.png" : "assets/ic_white_check.png", width: 15), SizedBox(width: 3), Text(LanguageService.trans("receipt_verify"), style: AppTextStyle.PD(Colors.white, 12))],
                      ),
                    ),
                    Image.asset("assets/ic_more.png", width: 25, height: 25),
                  ],
                ),
                SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H16(
                      text: widget.item.hospital_name,
                      weight: FW.bold,
                      height: 1.5,
                    ),
                    H12(
                      text: getDateFormatString(DateTime.parse(widget.item.created_at), "yyyy-MM-dd"),
                      weight: FW.semi_bold,
                      color: AppColor_GrayText,
                      height: 1.5,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Stack(
                  children: [
                    widget.item.status == 'testing'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset("assets/ic_red_heart_off.png", width: 15, height: 15),
                              SizedBox(width: 7),
                              H14(text: LanguageService.trans("this_like"), weight: FW.bold, color: AppColor_Selector_Border),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset("assets/ic_like_on.png", width: 15, height: 15),
                              SizedBox(width: 5),
                              H14(text: LanguageService.trans("this_like"), weight: FW.bold, color: AppColor_Primary),
                            ],
                          ),
                  ],
                ),
                const SizedBox(height: 16),
                ReadMoreText(
                  widget.item.description,
                  trimLines: 4,
                  style: AppTextStyle.PD(Colors.black, 16, height: 1.2, weight: FW.regular),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: LanguageService.trans("more"),
                  trimExpandedText: 'less',
                  moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor_Primary),
                  lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColor_Primary),
                ),
                // H14(text:widget.item.description, weight: FW.regular,
                //   height: 1.5,
                //   maxLine: 4,
                //   align: TextAlign.left,
                // ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H14(
                      text: makeStr(widget.item.user_name) + " " + LanguageService.trans("nim"),
                      weight: FW.bold,
                      height: 1.5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(5),
                          color: Colors.transparent,
                          border: Border.all(color: AppColor_Gray),
                          borderRadius: BorderRadius.circular(6.0)),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            H14(text: LanguageService.trans("helped"), weight: FW.medium),
                            const SizedBox(width: 10),
                            Image.asset(widget.item.like_yn == 'y' ? "assets/ic_like_on.png" : "assets/ic_red_heart_off.png", width: 15, height: 15),
                            const SizedBox(width: 2),
                            H14(text: widget.item.like_cnt.toString(), weight: FW.medium),
                          ],
                        ),
                        onTap: widget.onLikeReview,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
              ],
            ),
          ),
          Container(
            height: 8,
            color: AppColor_Light_Gray,
          ),
        ],
      ),
    );
  }

  void onDetail() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReviewDetailPage(item: widget.item)));
  }
}
