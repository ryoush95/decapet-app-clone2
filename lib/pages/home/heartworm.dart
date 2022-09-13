import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/drug_dto.dart';
import 'package:decapet/models/dto/inoculation_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/calendar.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/selector1.dart';
import 'package:flutter/material.dart';

import '../components/simple_header.dart';

class HeartWormPage extends StatefulWidget {
  final InoculationDto inoculation;
  final String type;
  final String animal_type;
  final int pet_uid;

  HeartWormPage({
    Key? key,
    required this.type,
    required this.animal_type,
    required this.inoculation,
    required this.pet_uid,
  }) : super(key: key);

  @override
  HeartWormPageState createState() => HeartWormPageState();
}

class HeartWormPageState extends BaseState<HeartWormPage> {
  String title = "";
  DateTime? date;
  int drugId = 0;
  String drugName = "";

  List<DrugItemDto> drugList = [];
  List<String> drugStringList = [];

  bool isValid = false;

  @override
  void initState() {
    super.initState();
    if (widget.inoculation.inoculation_date.isNotEmpty) {
      date = DateTime.parse(widget.inoculation.inoculation_date);
      drugId = widget.inoculation.drug_id;
      drugName = widget.inoculation.drug_name;
    }

    if (widget.type == "rabies") {
      title = LanguageService.trans("rabies_vaccination");
    } else if (widget.type == "heartworm") {
      getDrugList();
      title = LanguageService.trans("heartworm");
    } else {
      getDrugList();
      title = LanguageService.trans("ectoparasite");
    }
    checkValid();
  }

  void checkValid() {
    if (widget.type == "rabies") {
      setState(() {
        isValid = date != null;
      });
    } else {
      isValid = date != null && drugId != 0;
    }
  }

  void getDrugList() {
    showLoading();
    try {
      api.drug_list1(user.info.access_token, widget.animal_type, widget.type, widget.pet_uid).then((value) {
        hideLoading();
        if (value.result == 0) {
          drugList.addAll(value.data!.list);
          value.data!.list.forEach((element) {
            drugStringList.add(element.name);
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
    showLoading();
    try {
      api.add_inoculation(user.info.access_token, widget.pet_uid, widget.type, date.toString(), drugId).then((value) {
        hideLoading();
        if (value.result == 0) {
          event.fire(ChangeInoculation(widget.type, getDateFormatString(date!, "yyyy-MM-dd"), drugId, drugName, widget.pet_uid));
          Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleHeader(
            title: title,
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: H20(
                    text: LanguageService.trans("heartworm_title"),
                    maxLine: 2,
                    height: 1.5,
                    align: TextAlign.left,
                    //weight: ,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 25,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/date_range_black_24dp.png', width: 25),
                      SizedBox(
                        width: 5,
                      ),
                      H20(
                        text: date == null ? LanguageService.trans("select_date") : getDateFormatString(date!, "MMMMEEEEd"),
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/expand_circle_down_black_24dp.png',
                          width: 20,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AppCalendar(
                  current: date,
                  onDateSelected: (datetime) {
                    setState(() {
                      date = datetime;
                    });
                    checkValid();
                  },
                ),
                Visibility(
                  visible: false,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Expanded(child: Container()),
                        Image.asset(
                          'assets/icon_check_on.png',
                          height: 20,
                          color: AppColor_Primary,
                        ),
                        const SizedBox(width: 5),
                        H14(
                          text: LanguageService.trans("Selection"),
                          weight: FW.medium,
                          color: AppColor_GrayText,
                        ),
                        const SizedBox(width: 10),
                        Image.asset('assets/icon_check_off.png', height: 20),
                        const SizedBox(width: 5),
                        H14(text: LanguageService.trans("Impossible"), weight: FW.medium, color: AppColor_GrayText)
                      ])),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 8,
                  color: Color(0xFFF8F9FA),
                ),
                Visibility(
                  visible: widget.type != "rabies",
                  child: Container(
                    //padding: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/medication_black_24dp.png', width: 25),
                            SizedBox(
                              width: 5,
                            ),
                            H20(
                              text: LanguageService.trans("drug_selection"),
                            ),
                          ],
                        ),
                        Selector1(
                            selectedCategory: drugName,
                            categoryList: drugStringList,
                            onSelect: (index) {
                              setState(() {
                                drugName = drugList[index].name;
                                drugId = int.parse(drugList[index].id);
                              });
                              checkValid();
                            },
                            hint: LanguageService.trans("drug_selection_description")),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MainTextButton(
                    text: LanguageService.trans("to_save"),
                    backgroundColor: AppColor_Primary,
                    style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                    //width: 360,
                    height: 58,
                    disable: !isValid,
                    disableBackground: isValid ? AppColor_Primary : AppColor_Primary_Disable,
                    onPressed: () {
                      onNext();
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
