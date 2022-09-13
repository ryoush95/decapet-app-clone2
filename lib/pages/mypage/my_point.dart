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

class MyPointPage extends StatefulWidget {
  const MyPointPage({Key? key}) : super(key: key);

  @override
  MyPointPageState createState() => MyPointPageState();
}

class MyPointPageState extends BaseState<MyPointPage> {
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

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
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
    return PageLayout(
        isLoading: isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleHeader(
              title: LanguageService.trans('my_point'),
              onBackPressed: onBackPressed,
            ),
            const SizedBox(height: 31),
            //email
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: H14(
                text: LanguageService.trans('my_point'),
                weight: FW.medium,
                align: TextAlign.start,
                color: AppColor_Input_Title,
              ),
            ),
            const SizedBox(height: 13),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              /*decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(8.0),
                        color: AppColor_Out_Way,
                      ),*/
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  H28(
                    text: formatAmount(user.info.my_point),
                    weight: FW.bold,
                    align: TextAlign.start,
                    color: AppColor_BlackText,
                  ),
                  H20(
                    text: " " + LanguageService.trans("point"),
                    weight: FW.bold,
                    align: TextAlign.start,
                    color: AppColor_BlackText,
                  ),
                  //const SizedBox(width: 150),
                  Expanded(child: Container()),
                  Image.asset('assets/savings_black_24dp.png', width: 25, height: 25),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  //border: Border.all(color: AppColor_Red, width: 1.0),
                  color: AppColor_BlackText,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton1(
                //text: sprintf(LanguageService.trans("point_desc"), [formatAmount(user.info.my_point)]),
                text: sprintf(LanguageService.trans("point_desc"), [formatAmount(10000)]),
                backgroundColor: AppColor_BlackText,
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                height: 77,
                onPressed: () {
                  goReviewWrite();
                },
              ),
            ),
            const SizedBox(height: 63),

            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 25, 0),
              child: H18(
                text: LanguageService.trans('Usage_history'),
                weight: FW.bold,
                align: TextAlign.start,
                color: AppColor_BlackText,
              ),
            ),
            Expanded(
              //child: Container(
              //height: double.infinity,
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    return PointHistoryItem(
                      item: pointList[index],
                    );
                  },
                  itemCount: pointList.length,
                ),
              ),
            ),
            //),
          ],
        ));
  }
}
