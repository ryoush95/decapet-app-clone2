import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/review/photo_view.dart';
import 'package:decapet/pages/review/review_detail.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class HospitalInfoBottomItemData {
  String title;
  String image;
  String text;
  String btn_text;

  HospitalInfoBottomItemData({
    required this.title,
    required this.image,
    required this.text,
    required this.btn_text,
  });
}

class HospitalInfoBottomItem extends StatefulWidget {
  ReviewDto item;

  HospitalInfoBottomItem({required this.item});

  @override
  HospitalInfoBottomItemState createState() => HospitalInfoBottomItemState();
}

class HospitalInfoBottomItemState extends BaseState<HospitalInfoBottomItem> {
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

  void onViewMore() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReviewDetailPage(item: widget.item)));
  }

  void goReviewDetail() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReviewDetailPage(item: widget.item)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 20),
      decoration: BoxDecoration(color: AppColor_Light_Gray, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: H12(
                text: purpose.join(","),
                align: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(context, SlideRightTransRoute(builder: (context) => PhotoViewPage(img: widget.item.review_images)));
            },
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExtendedImage(
                  image: NetworkImage(widget.item.review_images),
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
              child: H14(
            color: AppColor_GrayText,
            text: widget.item.description,
            align: TextAlign.left,
            weight: FW.medium,
            height: 1.2,
            maxLine: 5,
          )),
          InkWell(
            onTap: goReviewDetail,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                H14(
                  text: LanguageService.trans('more'),
                  align: TextAlign.right,
                  color: AppColor_Primary,
                  weight: FW.bold,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
