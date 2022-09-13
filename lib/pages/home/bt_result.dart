import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/models/dto/br_dto.dart';
import 'package:decapet/models/dto/bt_result_item_dto.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/slide_bar.dart';
import 'package:flutter/material.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';

import '../components/simple_header.dart';

class BTResultPage extends StatefulWidget {
  int petUid;
  String date;

  BTResultPage({
    Key? key,
    required this.petUid,
    required this.date,
  });

  @override
  BTResultPageState createState() => BTResultPageState();
}

class BTResultPageState extends BaseState<BTResultPage> {

  List<BRDto> items = [];
  int cbcNum = 0;
  int serumNum = 0;
  int electroNum = 0;
  int sdmaNum = 0;
  int proNum = 0;

  String typesString = "";

  @override
  void initState() {
    super.initState();
    loadBtResult();
  }

  void loadBtResult() {
    showLoading();
    try {
      api.btResult(user.info.access_token, widget.petUid, widget.date).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            items.addAll(value.data!.list);
            cbcNum = value.data!.cbc_cnt;
            serumNum = value.data!.serum_cnt;
            electroNum = value.data!.electro_cnt;
            sdmaNum = value.data!.sdma_cnt;
            proNum = value.data!.pro_cnt;
            typesString = cbcNum > 0? LanguageService.trans('cbc') + ', ': ''
                + (serumNum > 0? LanguageService.trans('chem') + ', ': '')
                + (electroNum > 0? LanguageService.trans('electro') + ', ': '')
                + (sdmaNum > 0? LanguageService.trans('sdma') + ', ': '')
                + (proNum > 0? LanguageService.trans('pro'): '');

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

  void onNext() {
    return;
  }

  bool isNormal(String min, String max, String value) {
    if (double.parse(min) <= double.parse(value) && double.parse(max) >= double.parse(value)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  Widget btTable(String type) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 800,
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: H14(
                        text: LanguageService.trans('name'),
                        align: TextAlign.center,
                        weight: FW.bold,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: H14(
                        text: LanguageService.trans('reference'),
                        align: TextAlign.center,
                        weight: FW.bold,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: H14(
                        text: LanguageService.trans('result'),
                        align: TextAlign.center,
                        weight: FW.bold,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: H14(
                        text: LanguageService.trans('unit'),
                        align: TextAlign.center,
                        weight: FW.bold,
                      ),
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: Container()
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 800,
              child: const AppDivider(height: 2.0, color: Colors.black),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (items[index].type == type) {
                        return SizedBox(
                          height: 26,
                          child: Center(
                            child: Row(
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: H14(
                                    text: items[index].name,
                                    align: TextAlign.center,
                                    weight: FW.regular,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: H14(
                                    text: items[index].reference_min + ' ~ ' + items[index].reference_max,
                                    align: TextAlign.center,
                                    weight: FW.regular,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: H14(
                                    text: items[index].value,
                                    align: TextAlign.center,
                                    weight: FW.regular,
                                    color: isNormal(items[index].reference_min, items[index].reference_max, items[index].value)? AppColor_BlackText: Colors.red,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 1,
                                  child: H14(
                                    text: items[index].unit,
                                    align: TextAlign.center,
                                    weight: FW.regular,
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 3,
                                  child: SlideBar(
                                      height: 5,
                                      min: double.parse(items[index].reference_min),
                                      max: double.parse(items[index].reference_max),
                                      value: double.parse(items[index].value),
                                      color: isNormal(items[index].reference_min, items[index].reference_max, items[index].value)? Colors.blue:Colors.red ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(height: 0);
                      }
                    },
                    itemCount: items.length),
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleHeader(
            title: LanguageService.trans("child_treat_chart"),
            maxline: 2,
            onBackPressed: onBackPressed,
          ),
          const AppDivider(height: 10.0),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(width: 24),
              H20(
                text: LanguageService.trans("blood_collection") + " " +
                    getDateFormatString(
                        DateTime.parse(widget.date),
                        "MMMM dd, yy"),
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 24),
              H16(
                text: typesString,
                weight: FW.medium,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: cbcNum > 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const SizedBox(width: 24),
                            H16(text: LanguageService.trans('blood_cell_count')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            height: 165,
                            // width: double.infinity,
                            child: btTable('cbc')
                        ),
                      ],
                    )
                  ),
                  Visibility(
                    visible: serumNum > 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 23),
                        Row(
                          children: [
                            const SizedBox(width: 24),
                            H16(text: LanguageService.trans('serum_test')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            height: 170,
                            // width: double.infinity,
                            child: btTable('serum')
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: electroNum > 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 23),
                        Row(
                          children: [
                            const SizedBox(width: 24),
                            H16(text: LanguageService.trans('electrolyte_test')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            height: 170,
                            // width: double.infinity,
                            child: btTable('electro')
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: sdmaNum > 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 23),
                        Row(
                          children: [
                            const SizedBox(width: 24),
                            H16(text: LanguageService.trans('kidney')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            height: 110,
                            // width: double.infinity,
                            child: btTable('sdma')
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: proNum > 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 23),
                        Row(
                          children: [
                            const SizedBox(width: 24),
                            H16(text: LanguageService.trans('pro_bnp')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            height: 110,
                            // width: double.infinity,
                            child: btTable('pro')
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
