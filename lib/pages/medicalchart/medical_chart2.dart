import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/items/hospital_item.dart';
import 'package:flutter/material.dart';

import '../components/simple_header.dart';
import 'medical_chart3.dart';

class MedicalChartPage2 extends StatefulWidget {
  final int petUid;
  final String symptom;
  String animaltype;
  MedicalChartPage2({Key? key, required this.petUid, required this.symptom, this.animaltype = "all"}) : super(key: key);

  @override
  MedicalChartPage2State createState() => MedicalChartPage2State();
}

class MedicalChartPage2State extends BaseState<MedicalChartPage2> {
  List<HospitalItemData> hospitalList = [];
  ScrollController scrollController = ScrollController();

  bool isLast = false;
  int page = 0;
  int nSeletedHospital = 0;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()..addListener(loadMore);
    loadHospitalList();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void loadHospitalList() {
    showLoading();
    try {
      api.hospital_list(user.info.access_token, page, "review", "", "", "", "", "", "", "", "all").then((value) {
        hideLoading();
        if (value.result == 0) {
          if (page == 0) {
            hospitalList.clear();
          }
          for (HospitalDto item in value.data!.list) {
            hospitalList.add(HospitalItemData(id: item.id, isSelected: false, data: item));
          }
          isLast = value.data!.isLast;
          setState(() {});
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 200));
    page = 0;
    loadHospitalList();
  }

  void loadMore() {
    if (!isLoading) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadHospitalList();
      }
    }
  }

  void goChatting() {}

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        isLoading: isLoading,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SimpleHeader(
            title: LanguageService.trans('create_medical_chart'),
            onBackPressed: onBackPressed,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: H18(text: LanguageService.trans("select_animal_hospital")),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return HospitalItem(
                        item: hospitalList[index],
                        onSelect: (selectedIndex) {
                          setState(() {
                            nSeletedHospital = selectedIndex;
                            for (HospitalItemData data in hospitalList) {
                              if (data.id != selectedIndex) {
                                data.isSelected = false;
                              }
                            }
                          });
                        },
                      );
                    },
                    itemCount: hospitalList.length),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MainTextButton(
                  text: LanguageService.trans("next"),
                  backgroundColor: Colors.blue,
                  disable: nSeletedHospital == 0,
                  disableBackground: nSeletedHospital == 0 ? AppColor_Primary_Disable : Colors.transparent,
                  style: AppTextStyle.PD(Colors.white, 18, weight: FW.medium),
                  //width: 350,
                  height: 58,
                  onPressed: () {
                    onNext();
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ))
        ]));
  }

  void onNext() {
    Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => MedicalChartPage3(
                  petUid: widget.petUid,
                  symptom: widget.symptom,
                  hospitalUid: nSeletedHospital,
                )));
  }
}
