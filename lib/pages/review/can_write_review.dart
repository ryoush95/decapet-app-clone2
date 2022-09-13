import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/local_service.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/chart_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/home/my_child_treatment_chart_treatment.dart';
import 'package:decapet/pages/home/write_receipt_review.dart';
import 'package:decapet/pages/home/write_receipt_review_start.dart';
import 'package:decapet/pages/items/review_can_item.dart';
import 'package:flutter/material.dart';

import '../components/simple_header.dart';

class CanWriteReviewPage extends StatefulWidget {
  @override
  CanWriteReviewPageState createState() => CanWriteReviewPageState();
}

class CanWriteReviewPageState extends BaseState<CanWriteReviewPage> {
  List<ChartDto> descList = [];
  ScrollController controller = ScrollController();

  bool isLast = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(onScroll);
    loadCanWriteReviewDesc();

    event.on<ChangeReview>().listen((event) {
      if (mounted) {
        loadCanWriteReviewDesc();
      }
    });
  }

  void onScroll() {
    if (!isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadCanWriteReviewDesc();
      }
    }
  }

  Future<void> refresh() async {
    page = 0;
    loadCanWriteReviewDesc();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void loadCanWriteReviewDesc() {
    showLoading();
    try {
      api.available_list(user.info.access_token, 0).then((value) {
        hideLoading();
        if (value.result == 0) {
          if (page == 0) {
            descList.clear();
          }
          setState(() {
            descList.addAll(value.data!.list);
            isLast = value.data!.isLast;
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


  Future<void> onReviewWrite(id, hospitalName) async {
    int showGuide = await LocalService.getShowReviewGuide();
    if (showGuide == 1) {
      Navigator.push(
          context,
          SlideRightTransRoute(
              builder: (context) => WriteReceiptReviewPage(
                medicalUid: id,
                hospitalName: hospitalName,
                hospitalUid: 0,
                reviewId: 0,
              )));
    } else {
      Navigator.push(
          context,
          SlideRightTransRoute(
              builder: (context) => WriteReceiptReviewStartPage(
                medicalUid: id,
                hospitalName: hospitalName,
                hospitalUid: 0,
              )));
    }
  }

  void onViewMedicalChart(id) {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => MyChildTreatmentCharTreatment(id: id, status: 'no_review',)));
    // showLoading();
    // try {
    //   api.view_chart(user.info.access_token, id).then((value) {
    //     hideLoading();
    //     if (value.result == 0) {
    //       ChartDto item = value.data!;
    //       item.status = "no_review";
    //       Navigator.push(context, SlideRightTransRoute(builder: (context) => MyChildTreatmentCharTreatment(id: id, status: 'no_review',)));
    //     } else {
    //       showToast(value.msg!);
    //     }
    //   });
    // } on Exception catch (_, e) {
    //   hideLoading();
    //   showToast(LanguageService.trans("network_error"));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans("review_title"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            //child: Container(
            //height: double.infinity,
            child: RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                controller: controller,
                itemBuilder: (BuildContext context, int index) {
                  return ReviewCanItem(
                    item: descList[index],
                      onWrite: () => {
                        onReviewWrite(descList[index].id, descList[index].hospital_name)
                      }, onViewChart: () => {
                    onViewMedicalChart(descList[index].id)
                  }
                  );
                },
                itemCount: descList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
