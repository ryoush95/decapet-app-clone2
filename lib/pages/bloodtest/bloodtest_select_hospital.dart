import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_left_button.dart';
import 'package:decapet/pages/components/search_input.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/home/write_receipt_review.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'bloodtest_select_datetime.dart';

class BloodTestAppSelectHospitalPage extends StatefulWidget {
  List<int>? btIds;
  String? accidentYn;
  int? petId;
  String? animalType;
  final String fromPath;

  BloodTestAppSelectHospitalPage({Key? key, this.btIds, this.accidentYn, this.petId, required this.fromPath, this.animalType = "all"}) : super(key: key);

  @override
  BloodTestAppSelectHospitalPageState createState() => BloodTestAppSelectHospitalPageState();
}

class BloodTestAppSelectHospitalPageState extends BaseState<BloodTestAppSelectHospitalPage> {
  List<HospitalDto> hospitalList = [];
  ScrollController controller = ScrollController();
  var keywordController = TextEditingController();
  int totals = 0;

  HospitalDto hospital = new HospitalDto();

  List<String> regionList = [];
  List<String> sphereList = [];

  bool isLast = false;
  int page = 0;

  String region = "";
  String sphere = "";

  String buttonText = LanguageService.trans("select_a_hospital");

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(onScroll);
    getRegionSphere("");
    loadHospitalList();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void getRegionSphere(_region) {
    showLoading();
    try {
      api.regionSphere(user.info.access_token, _region).then((value) {
        hideLoading();
        if (value.result == 0) {
          if (_region.isEmpty) {
            regionList = value.data!.list;
          } else {
            sphereList = value.data!.list;
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

  void onReserve() {
    if (hospital.id == 0) {
      return;
    }

    if (widget.fromPath == "selopt") {
      Navigator.of(context).pop(hospital);
    }
    if (widget.fromPath == "review") {
      Navigator.push(
          context,
          SlideRightTransRoute(
              builder: (context) => WriteReceiptReviewPage(
                    medicalUid: 0,
                    hospitalName: hospital.name,
                    hospitalUid: hospital.id,
                    reviewId: 0,
                  )));
    }
    if (widget.fromPath == "blood_test") {
      Navigator.push(
        context,
        SlideRightTransRoute(
          builder: (context) => BloodTestSelectDateTimePage(
            petId: widget.petId!,
            btIds: widget.btIds!,
            accidentYn: widget.accidentYn!,
            hospital: hospital,
          ),
        ),
      );
    }
  }

  Future<void> refresh() async {
    page = 0;
    loadHospitalList();
  }

  void onScroll() {
    if (!isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadHospitalList();
      }
    }
  }

  void loadHospitalList() {
    showLoading();
    try {
      api.hospital_list(user.info.access_token, page, "review", keywordController.text, region, sphere, "", "", "", widget.fromPath == "blood_test" ? "y" : "", widget.animalType!).then((value) {
        hideLoading();
        if (value.result == 0) {
          if (page == 0) {
            hospitalList.clear();
          }
          setState(() {
            hospitalList.addAll(value.data!.list);
            totals = value.data!.totalCountNoFilter;
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

  void onSelectCondition(categoryList, type) {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      hospital = new HospitalDto();
                      buttonText = LanguageService.trans("select_a_hospital");
                      if (type == "region") {
                        region = categoryList[index];
                        sphere = "";
                        getRegionSphere(region);
                      } else {
                        sphere = categoryList[index];
                      }
                    });
                    loadHospitalList();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: H20(
                            text: categoryList[index],
                            align: TextAlign.left,
                            weight: FW.medium,
                            color: AppColor_BlackText,
                            height: 1.8,
                          ),
                        ),
                        Image.asset(
                          type == "region" ? (region == categoryList[index] ? 'assets/ic_radio_on.png' : 'assets/ic_radio_off.png') : (sphere == categoryList[index] ? 'assets/ic_radio_on.png' : 'assets/ic_radio_off.png'),
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: categoryList.length),
        );
      },
    );
  }

  void onSelectHospitalItem(int index) {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      hospital = hospitalList[index];
      if (widget.fromPath == "review") {
        buttonText = "[" + getGuName(hospitalList[index].address) + "]" + hospitalList[index].name + "\n" + LanguageService.trans("reg_own_review");
      } else {
        buttonText = "[" + getGuName(hospitalList[index].address) + "]" + hospitalList[index].name + "\n" + LanguageService.trans("reserve");
      }
    });
  }

  void onFavorite(int index) {
    FocusScope.of(context).requestFocus(FocusNode());
    String favoriteYn = hospitalList[index].like_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.setFavorite(user.info.access_token, hospitalList[index].id, favoriteYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            hospitalList[index].like_yn = favoriteYn;
            if (favoriteYn == "y") {
              hospitalList[index].like_cnt = hospitalList[index].like_cnt + 1;
            } else {
              hospitalList[index].like_cnt = hospitalList[index].like_cnt - 1;
            }
          });
        } else {
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
    final node = FocusScope.of(context);
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: widget.fromPath == "review" ? LanguageService.trans('reg_own_review') : LanguageService.trans('blood_test_app'),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: H20(
                    text: LanguageService.trans('select_available_hospital'),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SearchInput(
                    placeholder: LanguageService.trans("enter_hospital_name"),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      hospital = HospitalDto();
                      buttonText = LanguageService.trans("select_a_hospital");
                      page = 0;
                      loadHospitalList();
                    },
                    controller: keywordController,
                    onChanged: (String keyword) {},
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 50 - 8 - 4) / 2,
                        child: MainTextLeftButton(
                          borderColor: AppColor_Gray,
                          showBorder: true,
                          backgroundColor: AppColor_White,
                          style: AppTextStyle.PD(region.isEmpty ? AppColor_Gray : AppColor_BlackText, 16, weight: FW.medium),
                          text: region.isEmpty ? LanguageService.trans("enter_region") : region,
                          onPressed: () {
                            onSelectCondition(regionList, "region");
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: (MediaQuery.of(context).size.width - 50 - 8 - 4) / 2,
                        child: MainTextLeftButton(
                          borderColor: AppColor_Gray,
                          showBorder: true,
                          backgroundColor: AppColor_White,
                          style: AppTextStyle.PD(sphere.isEmpty ? AppColor_Gray : AppColor_BlackText, 16, weight: FW.medium),
                          text: sphere.isEmpty ? LanguageService.trans("enter_sphere") : sphere,
                          onPressed: () {
                            onSelectCondition(sphereList, "sphere");
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      H16(
                        text: keywordController.text.isEmpty && region.isEmpty && sphere.isEmpty ? LanguageService.trans("all") : LanguageService.trans("result"),
                      ),
                      const SizedBox(width: 20),
                      H16(
                        text: (keywordController.text.isEmpty && region.isEmpty && sphere.isEmpty ? totals.toString() : hospitalList.length.toString()) + LanguageService.trans("gae"),
                        color: AppColor_Primary,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 50, left: 25, right: 25),
                      controller: controller,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(23),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: hospitalList[index].id == hospital.id ? AppColor_Primary : AppColor_Gray)),
                          margin: EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () {
                              onSelectHospitalItem(index);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ExtendedImage(
                                      image: NetworkImage(hospitalList[index].image),
                                      height: 170,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                H16(
                                  text: "[" + getGuName(hospitalList[index].address) + "]" + hospitalList[index].name,
                                  weight: FW.semi_bold,
                                  align: TextAlign.left,
                                ),
                                const SizedBox(height: 10),
                                H14(
                                  text: hospitalList[index].address,
                                  weight: FW.regular,
                                  align: TextAlign.left,
                                  color: AppColor_BlackText,
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    onFavorite(index);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(hospitalList[index].like_yn == "y" ? "assets/ic_like_on.png" : "assets/ic_like_off.png", width: 15, height: 15),
                                      const SizedBox(width: 5),
                                      H14(
                                        text: hospitalList[index].like_cnt.toString(),
                                        weight: FW.bold,
                                        color: AppColor_Primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: hospitalList.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              child: Container(
                color: hospital.id == 0 ? AppColor_Primary_Disable : AppColor_Primary,
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                  ),
                ),
              ),
              onTap: onReserve,
            ),
          ),
        ],
      ),
    );
  }
}
