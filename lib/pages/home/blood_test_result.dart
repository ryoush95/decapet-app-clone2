import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/br_dto.dart';
import 'package:decapet/models/dto/bt_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/material.dart';

import '../components/simple_header.dart';

class BloodTestResultPage extends StatefulWidget {
  int petUid;

  BloodTestResultPage({
    Key? key,
    required this.petUid,
  }) : super(key: key);

  @override
  BloodTestResultState createState() => BloodTestResultState();
}

class BloodTestResultState extends BaseState<BloodTestResultPage> {
  List<BRDto> resultList = [];
  List<BtDto> itemList = [];
  int dateNum = 0;
  int itemNum = 0;

  int cbcNum = 0;
  int serumNum = 0;
  int electroNum = 0;
  int sdmaNum = 0;
  int proNum = 0;
  String dates = "";

  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;
  int count5 = 0;

  void loadBtSubItems() {
    showLoading();

    try {
      api.btSubItems(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            itemList = value.data!.list;
            cbcNum = value.data!.cbc_cnt;
            serumNum = value.data!.serum_cnt;
            electroNum = value.data!.electro_cnt;
            sdmaNum = value.data!.sdma_cnt;
            proNum = value.data!.pro_cnt;
            itemNum = itemList.length;

            for (int i = 0; i < itemList.length; i++) {
              if (itemList.elementAt(i).type == "cbc") {
                count1++;
              }
              if (itemList.elementAt(i).type == "serum") {
                count2++;
              }
              if (itemList.elementAt(i).type == "electro") {
                count3++;
              }
              if (itemList.elementAt(i).type == "sdma") {
                count4++;
              }
              if (itemList.elementAt(i).type == "pro") {
                count5++;
              }
            }
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

  void loadBtResult() {
    showLoading();

    try {
      api.btResultAll(user.info.access_token, widget.petUid).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            resultList = value.data!.list;
            dates = value.data!.dates;
            dateNum = dates.split(',').length;
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

  @override
  void initState() {
    super.initState();
    loadBtSubItems();
    loadBtResult();
  }

  void onNext() {
    return;
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  Widget btTable(String type) {
    int count = 0;
    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].type == type) {
        count = count + 1;
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          width: 245 + 100.0 * dateNum,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // width: 300,
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 80,
                        child: H14(
                          text: "name",
                          align: TextAlign.center,
                          weight: FW.bold,
                        ),
                      ),
                      SizedBox(
                        width: 105,
                        child: H14(
                          text: LanguageService.trans('reference'),
                          align: TextAlign.center,
                          weight: FW.bold,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: H14(
                          text: LanguageService.trans('unit'),
                          align: TextAlign.center,
                          weight: FW.bold,
                        ),
                      ),
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int columnIndex) {
                          return SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: H14(
                                  text: dates.split(',')[columnIndex],
                                  align: TextAlign.center,
                                  weight: FW.bold,
                                ),
                              ));
                        },
                        itemCount: dateNum,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: 245 + 100.0 * dateNum,
                child: const AppDivider(height: 2.0, color: Colors.black),
              ),
              Container(
                height: count * 26,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (itemList[index].type == type) {
                        return SizedBox(
                          // width: 245 + 100.0 * dateNum,
                          height: 26,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: H14(
                                    text: itemList[index].detail,
                                    align: TextAlign.center,
                                    weight: FW.regular,
                                  ),
                                ),
                                SizedBox(
                                  width: 105,
                                  child: H14(
                                    text: convertNumber(itemList[index].reference_max) != '0'
                                        ? convertNumber(itemList[index].reference_min) + ' ~ ' + convertNumber(itemList[index].reference_max)
                                        : "",
                                    align: TextAlign.center,
                                    weight: FW.regular,
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: H14(
                                    text: itemList[index].unit,
                                    align: TextAlign.center,
                                    weight: FW.regular,
                                  ),
                                ),
                                ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int columnIndex) {
                                      for (int i = 0; i < resultList.length; i++) {
                                        if (resultList[i].type == type) {
                                          if (resultList[i].date == dates.split(',')[columnIndex] && resultList[i].name == itemList[index].detail) {
                                            return SizedBox(
                                                width: 100,
                                                height: 26,
                                                child: Center(
                                                  child: H14(
                                                    text: resultList[i].value,
                                                    align: TextAlign.center,
                                                    weight: FW.regular,
                                                    color:
                                                        (double.parse(itemList[index].reference_min) <= double.parse(resultList[i].value)
                                                        && double.parse(itemList[index].reference_max) >= double.parse(resultList[i].value))
                                                        || convertNumber(itemList[index].reference_max) == '0'
                                                        ?  AppColor_BlackText: AppColor_Red
                                                  ),
                                                ));
                                          }
                                        }
                                      }
                                      return SizedBox(
                                          width: 100,
                                          height: 26,
                                          child: Center(
                                            child: H14(
                                              text: "-",
                                              align: TextAlign.center,
                                              weight: FW.regular,
                                            ),
                                          ));
                                    },
                                    itemCount: dateNum),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(height: 0);
                      }
                    },
                    itemCount: itemList.length),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleHeader(
              title: LanguageService.trans("view_blood_test_results"),
              maxline: 2,
              onBackPressed: onBackPressed,
            ),
            Container(
              height: 8,
              color: Color(0xFFF8F9FA),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 23),
                    Row(
                      children: [
                        const SizedBox(width: 24),
                        H16(text: LanguageService.trans('blood_cell_count')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        height: count1 * 26 + 60,
                        // width: double.infinity,
                        child: btTable('cbc')),
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
                        height: count2 * 26 + 60,
                        // width: double.infinity,
                        child: btTable('serum')),
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
                        height: count3 * 26 + 60,
                        // width: double.infinity,
                        child: btTable('electro')),
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
                        height: count4 * 26 + 60,
                        // width: double.infinity,
                        child: btTable('sdma')),
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
                        height: count5 * 26 + 60,
                        // width: double.infinity,
                        child: btTable('pro')),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
