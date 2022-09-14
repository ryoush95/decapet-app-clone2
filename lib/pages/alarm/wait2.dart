import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/point_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/custom_button_1.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/h28.dart';
import 'package:decapet/pages/components/point_list_item.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class Wait2 extends StatefulWidget {
  const Wait2({Key? key}) : super(key: key);

  @override
  Wait2State createState() => Wait2State();
}

class Wait2State extends BaseState<Wait2> {
  List<PointDto> pointList = [];
  ScrollController controller = ScrollController();

  bool isLast = false;
  int page = 0;

  @override
  void initState() {
    controller = ScrollController()..addListener(onScroll);
    super.initState();

    loadPointHistory();
  }

  void goReviewWrite() {
    event.fire(pointReview());
    Navigator.of(context).pop();
  }

  void onScroll() {
    if (!isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadPointHistory();
      }
    }
  }

  Future<void> refresh() async {
    page = 0;
    loadPointHistory();
  }

  void loadPointHistory() {
    showLoading();
    try {
      api.pointHistory(user.info.access_token, page).then((res) {
        if (res.result == 0) {
          hideLoading();
          if (page == 0) {
            pointList.clear();
          }
          setState(() {
            pointList.addAll(res.data!.list);
            isLast = res.data!.isLast;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 40),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        //color: AppColor_Light_Blue,
        border: Border.all(color: Colors.transparent),
        borderRadius: const BorderRadius.all(Radius.circular(8)),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(height: 200),
          Center(
            child: H20(text: LanguageService.trans("service_wait"), color: AppColor_Primary, weight: FW.medium),
          ),
          const SizedBox(height: 25),
          Center(
            child: Image.asset('assets/ic_intro_logo.png', width: 80, height: 80),
          ),
          const SizedBox(height: 25),
          // Center(
          //   child: Image.asset('assets/add_circle_black_24dp.png', width: 15, height: 15),
          // ),
        ],
      ),
    );
  }
}
