import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/components/underline_input.dart';
import 'package:decapet/pages/items/symptom_item.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'medical_chart2.dart';

class MedicalChartPage1 extends StatefulWidget {
  final int petUid;
  final String petName;
  String animaltype;
  MedicalChartPage1({Key? key, required this.petUid, required this.petName, this.animaltype = "all"}) : super(key: key);

  @override
  MedicalChartPage1State createState() => MedicalChartPage1State();
}

class MedicalChartPage1State extends BaseState<MedicalChartPage1> {
  List<String> symptomList = [];
  ScrollController scrollController = ScrollController();
  List<String> selectedSymptoms = [];

  bool isLast = false;
  bool isValidNo = false;
  int page = 0;

  var inputController = TextEditingController();
  String inputContent = "";
  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()..addListener(loadMore);
    loadSymptomList();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void loadSymptomList() {
    try {
      api.symptom_list(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            symptomList = value.data!.list;
            symptomList.add(LanguageService.trans("other1"));
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

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 200));
    page = 0;
    loadSymptomList();
  }

  bool isSelected = false;
  int num_selected = 0;

  void loadMore() {
    if (!isLoading) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadSymptomList();
      }
    }
  }

  void onYes() {
    setState(() {
      isValidNo = false;
      isSick = "y";
      isSelected = selectedSymptoms.isNotEmpty;
    });
  }

  void onNo() {
    setState(() {
      isValidNo = true;
      isSick = "n";
      isSelected = true;
    });
  }

  void toggleSelect(bool state, String name) {
    if (state) {
      if (!selectedSymptoms.contains(name)) selectedSymptoms.add(name);
    } else {
      if (selectedSymptoms.contains(name)) selectedSymptoms.remove(name);
    }
    setState(() {
      isSelected = selectedSymptoms.isNotEmpty;
    });
  }

  bool isExistDireceInput() {
    return selectedSymptoms.contains(LanguageService.trans("other1"));
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
        isLoading: isLoading,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleHeader(
                    title: LanguageService.trans("create_medical_chart"),
                    onBackPressed: onBackPressed,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 130,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      H18(
                        text: getDateFormatString(DateTime.now(), "yyyy") + LanguageService.trans("year") + " " + getDateFormatString(DateTime.now(), "MMMM d") + LanguageService.trans("day1") + " " + getDateFormatString(DateTime.now(), "(EEE)"),
                      ),
                      SubstringHighlight(
                        text: widget.petName + " " + LanguageService.trans("are_you_sick"),
                        term: widget.petName,
                        textStyle: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.bold, height: 1.5),
                        textStyleHighlight: AppTextStyle.PD(
                          Colors.blue,
                          16,
                          weight: FW.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainTextButton(
                            text: LanguageService.trans("yes"),
                            style: AppTextStyle.PD(isValidNo ? Colors.black26 : Colors.blue, 16, weight: FW.bold),
                            width: 170,
                            //height: 120,
                            showBorder: isValidNo ? false : true,
                            borderColor: isValidNo ? Colors.transparent : Colors.lightBlueAccent,
                            backgroundColor: isValidNo ? AppColor_Light_Gray : AppColor_Light_Blue,
                            onPressed: () {
                              onYes();
                            },
                          ),
                          const SizedBox(height: 20),
                          MainTextButton(
                            text: LanguageService.trans("no"),
                            backgroundColor: !isValidNo ? AppColor_Light_Gray : AppColor_Light_Blue,
                            style: AppTextStyle.PD(!isValidNo ? Colors.black26 : Colors.blue, 16, weight: FW.bold),
                            showBorder: !isValidNo ? false : true,
                            borderColor: !isValidNo ? Colors.transparent : Colors.lightBlueAccent,
                            width: 170,
                            onPressed: () {
                              onNo();
                            },
                          ),
                        ],
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: H16(text: LanguageService.trans("Symptom"), height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: H14(text: LanguageService.trans("select_all"), weight: FW.regular),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return SymptomItem(
                            item: symptomList[index],
                            onChecked: (checked, name) {
                              toggleSelect(checked, name);
                            });
                      },
                      itemCount: symptomList.length),
                  Visibility(
                    visible: isExistDireceInput(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      margin: const EdgeInsets.only(top: 10),
                      child: UnderlineInput(
                        controller: inputController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        placeholder: LanguageService.trans("input_symptom"),
                        height: 50,
                        onChanged: (text) => {inputContent = text},
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainTextButton(
                      text: LanguageService.trans("next"),
                      backgroundColor: Colors.blue,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.medium),
                      //width: 350,
                      height: 58,
                      disable: !isSelected,
                      disableBackground: !isSelected ? AppColor_Primary_Disable : Colors.transparent,
                      onPressed: () {
                        onNext();
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ));
  }

  void onNext() {
    if (selectedSymptoms.isEmpty && !isValidNo) {
      return;
    }
    String content = selectedSymptoms.join(",");
    if (isExistDireceInput()) {
      if (inputContent.isEmpty) {
        showToast(LanguageService.trans("input_symptom"));
        return;
      }
      content = content.replaceAll(LanguageService.trans("other1"), inputContent);
    }

    Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => MedicalChartPage2(
                  petUid: widget.petUid,
                  symptom: selectedSymptoms.join(","),
                  animaltype: widget.animaltype,
                )));
  }
}
