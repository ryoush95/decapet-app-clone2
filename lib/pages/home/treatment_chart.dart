import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/local_service.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/chart_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/home/write_receipt_review.dart';
import 'package:decapet/pages/home/write_receipt_review_start.dart';
import 'package:decapet/pages/items/treatment_chart_item.dart';
import 'package:decapet/pages/medicalchart/medical_chart1.dart';
import 'package:flutter/material.dart';

import '../components/simple_header.dart';

class TreatmentChartPage extends StatefulWidget {
  final int petUid;
  final String petName;
  String animaltype;

  TreatmentChartPage({Key? key, required this.petUid, required this.petName, this.animaltype = "all"}) : super(key: key);

  @override
  TreatmentChartPageState createState() => TreatmentChartPageState();
}

class TreatmentChartPageState extends BaseState<TreatmentChartPage> {
  List<ChartDto> chatList = [];
  var scrollController = ScrollController();

  bool isLast = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(loadMore);
    getChartList();

    event.on<ChangeReview>().listen((event) {
      if (mounted) {
        for (ChartDto item in chatList) {
          if (item.id == event.recordUid) {
            setState(() {
              item.type = "testing";
            });
            break;
          }
        }
      }
    });

    event.on<ChangeRecord>().listen((event) {
      if (mounted) {
        getChartList();
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(loadMore);
    super.dispose();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 200));
    page = 0;
    getChartList();
  }

  void loadMore() {
    if (!isLoading) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        getChartList();
      }
    }
  }

  void getChartList() {
    showLoading();
    try {
      api.chart_list(user.info.access_token, widget.petUid, 0).then((value) {
        hideLoading();
        if (value.result == 0) {
          chatList.clear();
          chatList.addAll(value.data!.list);

          isLast = value.data!.isLast;
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

  void onChartWrite() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => MedicalChartPage1(petUid: widget.petUid, petName: widget.petName, animaltype: widget.animaltype)));
  }

  Future<void> onReviewWrite(index) async {
    int showGuide = await LocalService.getShowReviewGuide();
    if (showGuide == 1) {
      Navigator.push(
          context,
          SlideRightTransRoute(
              builder: (context) => WriteReceiptReviewPage(
                    medicalUid: chatList[index].id,
                    hospitalName: chatList[index].hospital_name,
                    hospitalUid: 0,
                    reviewId: 0,
                  )));
    } else {
      Navigator.push(
          context,
          SlideRightTransRoute(
              builder: (context) => WriteReceiptReviewStartPage(
                    medicalUid: chatList[index].id,
                    hospitalName: chatList[index].hospital_name,
                    hospitalUid: 0,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      onBack: onBackPressed,
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans("treatment_chart"),
            onBackPressed: onBackPressed,
          ),
          const AppDivider(height: 8.0, color: AppColor_Divider),
          Visibility(
              visible: chatList.isEmpty,
              child: Expanded(
                child: Container(
                  color: AppColor_Divider,
                  child: Center(
                    child: H16(
                      text: LanguageService.trans('there_is_no_chart'),
                      weight: FW.medium,
                      color: AppColor_GrayText,
                    ),
                  ),
                ),
              )),
          Visibility(
            visible: chatList.isNotEmpty,
            child: Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return TreatmentChartItem(
                        item: chatList[index],
                        petUid: widget.petUid,
                        onClickItem: () {},
                        onReviewWrite: () {
                          onReviewWrite(index);
                        },
                      );
                    },
                    itemCount: chatList.length),
              ),
            ),
          )
        ],
      ),
      floatingButton: FloatingActionButton(
        highlightElevation: 0,
        focusElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: onChartWrite,
        child: Image.asset("assets/add_circle_black_24dp.png"),
      ),
    );
  }
}
