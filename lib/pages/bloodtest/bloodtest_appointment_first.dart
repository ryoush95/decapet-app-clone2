import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/bt_dto.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/H26.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h22.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:flutter/material.dart';

import 'bloodtest_select_hospital.dart';

class BloodTestAppFirstPage extends StatefulWidget {
  final PetDto item;

  BloodTestAppFirstPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  BloodTestAppFirstPageState createState() => BloodTestAppFirstPageState();
}

class BloodTestAppFirstPageState extends BaseState<BloodTestAppFirstPage> {
  String level = "";
  String levelImage = "";
  String accidentYn = "n";

  List<int> btIds = [];
  List<BtDto> btList = [];
  List<BtDto> feeList = [];
  List<BtDto> cbcList = [];
  List<BtDto> serumList = [];
  List<BtDto> electroList = [];
  List<BtDto> sdmaList = [];
  List<BtDto> proList = [];

  @override
  void initState() {
    super.initState();
    getBtList();
    switch (widget.item.level) {
      case 'silver':
        level = LanguageService.trans("silver");
        levelImage = 'assets/silver.png';
        break;
      case 'gold':
        level = LanguageService.trans("gold");
        levelImage = 'assets/gold.png';
        break;
      case 'platinum':
        level = LanguageService.trans("platinum");
        levelImage = 'assets/platinum.png';
        break;
      case 'dia':
        level = LanguageService.trans("dia");
        levelImage = 'assets/dia.png';
        break;
      case 'bronze':
        level = LanguageService.trans("bronze");
        levelImage = 'assets/bronze.png';
        break;
      case 'iron':
        level = LanguageService.trans("iron");
        levelImage = 'assets/iron.png';
        break;
    }
  }

  void checkValid() {}

  void showCheckBeforeBookingDlg() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    H22(
                      text: LanguageService.trans("check_title"),
                      height: 1.5,
                    ),
                    const SizedBox(height: 20),
                    H18(
                      text: LanguageService.trans("check_comment"),
                      height: 1.5,
                      maxLine: 3,
                      align: TextAlign.left,
                      weight: FW.medium,
                    ),
                    const SizedBox(height: 20),
                    MainTextButton(
                      height: 58,
                      backgroundColor: AppColor_Primary,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                      text: LanguageService.trans("i_checked"),
                      onPressed: onChecked,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onFindAvailableHospital() {
    if (btIds.isEmpty) {
      return;
    }

    showCheckBeforeBookingDlg();
  }

  void getBtList() {
    showLoading();
    try {
      api.getBtItems(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          btList.addAll(value.data!.list);
          btList.forEach((element) {
            if (element.item_type == "fee") {
              feeList.add(element);
            } else if (element.item_type == "cbc") {
              cbcList.add(element);
            } else if (element.item_type == "serum") {
              serumList.add(element);
            } else if (element.item_type == "electro") {
              electroList.add(element);
            } else if (element.item_type == "sdma") {
              sdmaList.add(element);
            } else if (element.item_type == "pro") {
              proList.add(element);
            }
          });

          //TODO YJ
          if (feeList.isNotEmpty) {
            btIds.add(feeList[0].id);
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

  void onChecked() {
    Navigator.of(context).pop();
    Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => BloodTestAppSelectHospitalPage(
                  accidentYn: accidentYn,
                  btIds: btIds,
                  petId: widget.item.id,
                  fromPath: "blood_test",
                  animalType: widget.item.animal_type,
                )));
  }

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans("blood_test_app"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 18),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(widget.item.animal_type == "cat" ? 'assets/ic_cat.png' : 'assets/ic_dog.png', width: 27, height: 27),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          LanguageService.trans('unique_number') + widget.item.registration_number,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle.PD(AppColor_GrayText, 12, weight: FW.regular),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 26),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 24),
                                    Container(
                                      width: 94,
                                      height: 94,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color(0xFFF8F9FA),
                                      ),
                                      child: Image.asset(widget.item.animal_type == "cat" ? 'assets/ic_default_cat.png' : 'assets/ic_default_dog.png', width: 60, height: 60),
                                    ),
                                    const SizedBox(width: 30),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        H26(
                                          text: level,
                                          weight: FW.semi_bold,
                                          align: TextAlign.left,
                                          color: AppColor_GrayText,
                                        ),
                                        const SizedBox(height: 10),
                                        H16(
                                          text: widget.item.name,
                                          weight: FW.semi_bold,
                                          align: TextAlign.left,
                                          color: AppColor_BlackText,
                                        ),
                                        const SizedBox(height: 5),
                                        H14(
                                          text: widget.item.birth != '0000-00-00' ? widget.item.age.toString() + LanguageService.trans("sae") : LanguageService.trans("unknow"),
                                          weight: FW.medium,
                                          align: TextAlign.left,
                                          color: AppColor_GrayText,
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(levelImage, width: 30, height: 30),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(accidentYn == "y" ? 'assets/ic_blue_check.png' : 'assets/ic_circle_off.png', height: 25),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    LanguageService.trans("blood_test_accident"),
                                    style: AppTextStyle.PD(Colors.black54, 14, weight: FW.medium),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              accidentYn = accidentYn == "y" ? "n" : "y";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: AppColor_GrayBackround),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: feeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (btIds.contains(feeList[index].id)) {
                                  btIds.remove(feeList[index].id);
                                } else {
                                  btIds.add(feeList[index].id);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(btIds.contains(feeList[index].id) ? 'assets/ic_black_check.png' : 'assets/ic_circle_off.png', height: 25),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          feeList[index].name,
                                          style: AppTextStyle.PD(Colors.black, 18, height: 1.3, weight: FW.medium),
                                        ),
                                        Visibility(
                                          visible: feeList[index].detail.isNotEmpty,
                                          child: Text(
                                            feeList[index].detail,
                                            style: AppTextStyle.PD(AppColor_GrayText, 14, height: 1.5, weight: FW.medium),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  H18(
                                    text: formatAmount(feeList[index].price) + " " + LanguageService.trans("won"),
                                    color: Colors.black,
                                    weight: FW.bold,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: AppColor_Light_Blue),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cbcList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (btIds.contains(cbcList[index].id)) {
                                  btIds.remove(cbcList[index].id);
                                } else {
                                  btIds.add(cbcList[index].id);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(btIds.contains(cbcList[index].id) ? 'assets/ic_blue_check.png' : 'assets/ic_circle_off.png', height: 25),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cbcList[index].name,
                                          style: AppTextStyle.PD(Color(0xFF1A8DF0), 18, height: 1.3, weight: FW.medium),
                                        ),
                                        Visibility(
                                          visible: cbcList[index].detail.isNotEmpty,
                                          child: Text(
                                            cbcList[index].detail,
                                            style: AppTextStyle.PD(AppColor_GrayText, 14, height: 1.5, weight: FW.medium),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  H18(
                                    text: formatAmount(cbcList[index].price) + " " + LanguageService.trans("won"),
                                    color: Colors.black,
                                    weight: FW.bold,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF2F6FF)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: serumList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (btIds.contains(serumList[index].id)) {
                                  btIds.remove(serumList[index].id);
                                } else {
                                  btIds.add(serumList[index].id);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(btIds.contains(serumList[index].id) ? 'assets/ic_blue_check.png' : 'assets/ic_circle_off.png', height: 25),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          serumList[index].name,
                                          style: AppTextStyle.PD(Color(0xFF1A8DF0), 18, height: 1.3, weight: FW.medium),
                                        ),
                                        SizedBox(height: 5),
                                        Visibility(
                                          visible: serumList[index].detail.isNotEmpty,
                                          child: Text(
                                            serumList[index].detail,
                                            style: AppTextStyle.PD(AppColor_GrayText, 14, height: 1.5, weight: FW.medium),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  H18(
                                    text: formatAmount(serumList[index].price) + " " + LanguageService.trans("won"),
                                    color: Colors.black,
                                    weight: FW.bold,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF2F3FE)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: electroList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (btIds.contains(electroList[index].id)) {
                                  btIds.remove(electroList[index].id);
                                } else {
                                  btIds.add(electroList[index].id);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(btIds.contains(electroList[index].id) ? 'assets/ic_violett_check.png' : 'assets/ic_circle_off.png', height: 25),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          electroList[index].name,
                                          style: AppTextStyle.PD(Color(0xFF5A68FF), 18, height: 1.3, weight: FW.medium),
                                        ),
                                        SizedBox(height: 5),
                                        Visibility(
                                          visible: electroList[index].detail.isNotEmpty,
                                          child: Text(
                                            electroList[index].detail,
                                            style: AppTextStyle.PD(AppColor_GrayText, 14, height: 1.5, weight: FW.medium),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  H18(
                                    text: formatAmount(electroList[index].price) + " " + LanguageService.trans("won"),
                                    color: Colors.black,
                                    weight: FW.bold,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF4F2FF)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: sdmaList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (btIds.contains(sdmaList[index].id)) {
                                  btIds.remove(sdmaList[index].id);
                                } else {
                                  btIds.add(sdmaList[index].id);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(btIds.contains(sdmaList[index].id) ? 'assets/ic_violett_check.png' : 'assets/ic_circle_off.png', height: 25),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sdmaList[index].name,
                                          style: AppTextStyle.PD(Color(0xFFA274FF), 18, height: 1.3, weight: FW.medium),
                                        ),
                                        Visibility(
                                          visible: sdmaList[index].detail.isNotEmpty,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              Text(
                                                sdmaList[index].detail,
                                                style: AppTextStyle.PD(AppColor_GrayText, 14, height: 1.5, weight: FW.medium),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  H18(
                                    text: formatAmount(sdmaList[index].price) + " " + LanguageService.trans("won"),
                                    color: Colors.black,
                                    weight: FW.bold,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF6F2FE)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: proList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (btIds.contains(proList[index].id)) {
                                  btIds.remove(proList[index].id);
                                } else {
                                  btIds.add(proList[index].id);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(btIds.contains(proList[index].id) ? 'assets/ic_violett_check.png' : 'assets/ic_circle_off.png', height: 25),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          proList[index].name,
                                          style: AppTextStyle.PD(Color(0xFFA274FF), 18, height: 1.3, weight: FW.medium),
                                        ),
                                        Visibility(
                                          visible: proList[index].detail.isNotEmpty,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              Text(
                                                proList[index].detail,
                                                style: AppTextStyle.PD(AppColor_GrayText, 14, height: 1.5, weight: FW.medium),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  H18(
                                    text: formatAmount(proList[index].price) + " " + LanguageService.trans("won"),
                                    color: Colors.black,
                                    weight: FW.bold,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              child: Container(
                color: btIds.isEmpty ? AppColor_Primary_Disable : AppColor_Primary,
                height: 58,
                width: double.infinity,
                child: Center(
                  child: Text(
                    LanguageService.trans("find_available_hospital"),
                    style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                  ),
                ),
              ),
              onTap: onFindAvailableHospital,
            ),
          )
        ],
      ),
    );
  }
}
