import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/models/dto/schedules_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/bloodtest/bloodtest_selopt.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/items/reserve_animal_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HospitalReserve extends StatefulWidget {
  HospitalDto hospital;

  HospitalReserve({Key? key, required this.hospital}) : super(key: key);

  @override
  HospitalReserveState createState() => HospitalReserveState();
}

class HospitalReserveState extends BaseState<HospitalReserve> {
  List<PetDto> petList = [];
  int petId = 0;

  @override
  void initState() {
    super.initState();

    loadPetList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 200));
    loadPetList();
  }

  void loadPetList() {
    showLoading();
    try {
      api.pet_list(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          petList.clear();
          for (PetDto item in value.data!.list) {
            petList.add(item);
          }
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
    return true;
  }

  void onClickReserve() {
    if (petId == 0) {
      return;
    }

    showLoading();
    try {
      api.hosiptalSchInfo(user.info.access_token, widget.hospital.id).then((value) {
        hideLoading();
        if (value.result == 0) {
          List<SchedulesDto> schList = value.data!.list;
          List<SchedulesDto> specialList = value.data!.special;
          String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
          Navigator.push(
            context,
            SlideRightTransRoute(
              builder: (context) => BloodTestAppSetOptPage(
                petId: petId,
                btIds: [],
                accidentYn: "n",
                hospital: widget.hospital,
                date: DateTime.parse(today),
                time: "",
                list: schList,
                specialList: specialList,
              ),
            ),
          );
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
  Widget build(BuildContext context) {
    return PageLayout(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleHeader(
              title: LanguageService.trans('do_reserve'),
              onBackPressed: onBackPressed,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: H20(
                text: LanguageService.trans('animal_select_after_reserve'),
                weight: FW.bold,
                color: AppColor_BlackText,
                maxLine: 2,
                height: 1.5,
                align: TextAlign.left,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ReserveAnimalItem(
                        isSelected: petId == petList[index].id,
                        item: petList[index],
                        onSelect: () {
                          if (widget.hospital.reservation_type == "all" || widget.hospital.reservation_type == petList[index].animal_type) {
                            setState(() {
                              petId = petList[index].id;
                            });
                          } else {
                            if (widget.hospital.reservation_type == "dog") {
                              showToast("개만 예약가능합니다.");
                            } else if (widget.hospital.reservation_type == "cat") {
                              showToast("고양이만 예약가능합니다.");
                            }
                          }
                        });
                  },
                  itemCount: petList.length),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: MainTextButton(
                      text: LanguageService.trans("next"),
                      backgroundColor: Colors.blue,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.medium),
                      width: double.infinity,
                      height: 58,
                      radius: 0,
                      disable: petId == 0,
                      disableBackground: petId == 0 ? AppColor_Primary_Disable : Colors.transparent,
                      onPressed: onClickReserve,
                    ),
                  )),
            ),
          ],
        ));
  }
}
