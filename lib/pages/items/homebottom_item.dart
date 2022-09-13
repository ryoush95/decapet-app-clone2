import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/review/review_detail.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBottomItem extends StatefulWidget {
  ReviewDto item;
  final onLikeReview;

  HomeBottomItem({required this.item, required this.onLikeReview});

  @override
  HomeBottomItemState createState() => HomeBottomItemState();
}

class HomeBottomItemState extends BaseState<HomeBottomItem> {
  List<String> purpose = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    widget.item.purpose.split(",").forEach((element) {
      purpose.add(LanguageService.trans(element));
    });
  }

  void goReviewDetail() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReviewDetailPage(item: widget.item)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: goReviewDetail,
      child: Container(
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15.0)), boxShadow: [
          BoxShadow(
            color: AppColor_Gray,
            blurRadius: 5.0, // soften the shadow
          )
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            H14(
              text: purpose.join(","),
              align: TextAlign.left,
              weight: FW.semi_bold,
            ),
            const SizedBox(height: 10),
            ExtendedImage(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: NetworkImage(widget.item.review_images),
              width: double.infinity,
              height: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Expanded(
                child: H12(
              color: AppColor_GrayText,
              text: widget.item.description,
              align: TextAlign.left,
              weight: FW.medium,
              height: 1.2,
            )),
            const SizedBox(height: 10),
            InkWell(
              onTap: widget.onLikeReview,
              child: Row(
                children: [
                  Image.asset(widget.item.like_yn == "y" ? 'assets/ic_like_on.png' : 'assets/ic_like_off.png', width: 15),
                  SizedBox(width: 5),
                  H12(
                    text: LanguageService.trans(widget.item.like_cnt.toString()),
                    align: TextAlign.left,
                    color: AppColor_Primary,
                    weight: FW.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
