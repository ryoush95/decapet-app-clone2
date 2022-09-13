import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/components/simple_header.dart';

class ReserveHistoryChangedPage extends StatefulWidget {
  @override
  ReserveHistoryChangedPageState createState() =>
      ReserveHistoryChangedPageState();
}

class ReserveHistoryChangedPageState
    extends BaseState<ReserveHistoryChangedPage> with TickerProviderStateMixin {
  int tabIndex = 0;
  bool showDetail = false;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      changeTab(tabController.index);
    });
  }

  void changeTab(int tab) {
    setState(() {
      showDetail = !showDetail;
      tabIndex = tab;
      tabController.index = tabIndex;
    });
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return true;
  }

  void onStartRecording() {
    Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => ReserveHistoryChangedPage()));
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        onBack: onBackPressed,
        isLoading: isLoading,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 20),
                SimpleHeader(
                  title: LanguageService.trans('reservation_history'),
                  onBackPressed: onBackPressed,
                ),
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SingleChildScrollView(
                      // padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: H24B(
                                  maxLine: 5,
                                  text: LanguageService.trans(
                                      'reservation_history_val'),
                                )),
                            const SizedBox(height: 20),
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: !showDetail,
                                    child: _buildTabHeaderItem(
                                        LanguageService.trans("0 bookings"), 0),
                                  ),
                                  Visibility(
                                    visible: !showDetail,
                                    child: _buildTabHeaderItem(
                                        LanguageService.trans(
                                            "past reservation"),
                                        1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 450,
                              color: AppColor_GrayBackround,
                              child: Center(
                                  child: H16(
                                color: AppColor_GrayText,
                                align: TextAlign.justify,
                                text: LanguageService.trans(showDetail == true
                                    ? 'No reservations right now:)'
                                    : 'There is no reservation record:)'),
                              )),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            )));
  }

  Widget _buildTabHeaderItem(String tabText, int step) {
    return InkWell(
      child: Stack(
        children: [
          SizedBox(
              width: (MediaQuery.of(context).size.width) / 3,
              height: 35,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: H14(
                        text: tabText,
                        color: tabIndex == step
                            ? Colors.black
                            : AppColor_Tab_Unselected,
                        weight: FW.regular,
                        maxLine: 2),
                  ),
                ],
              )),
        ],
      ),
      onTap: () {
        changeTab(step);
      },
    );
  }
}
