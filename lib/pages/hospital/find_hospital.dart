import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/app_info1_dto.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/H14.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/hospital/map_hospital.dart';
import 'package:decapet/pages/items/find_hospital_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FindHospital extends StatefulWidget {
  @override
  FindHospitalState createState() => FindHospitalState();
}

class FindHospitalState extends BaseState<FindHospital> {
  ScrollController scrollController = ScrollController();
  String region = "";
  List<HospitalDto> hospitalList = [];
  String intentGuide = "";
  var keywordController = TextEditingController();
  bool isLast = false;
  int page = 0;
  String speciality = "";

  // double myLatitude = 23;
  // double myLongitude = 35.5;

  int totals = 0;
  int totalsWithFilter = 0;

  // TODO YJ
  // MapCreateCallback? mapCreateCallback;
  // late CameraPosition initialCameraPosition;
  // List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(onScroll);
    // TODO YJ
    // initialCameraPosition = const CameraPosition(target: LatLng(37.74913611, 128.8784972));
    speciality = gStartInfo.hospital_services.elementAt(0).short_name;
    loadHospitalList();
    loadIntentGuide();
  }

  void loadHospitalList() {
    String temp = speciality == "전체" ? "" : speciality;
    showLoading();
    try {
      api.hospital_list(user.info.access_token, page, "likes", "", region, "", myLocLati.toString(), myLocLng.toString(), temp, "", "all").then((value) {
        hideLoading();
        if (value.result == 0) {
          if (page == 0) {
            hospitalList.clear();
          }
          setState(() {
            hospitalList.addAll(value.data!.list);
            totals = value.data!.totalCountNoFilter;
            isLast = value.data!.isLast;
            totalsWithFilter = value.data!.totalCount;
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

  void loadIntentGuide() {
    // showLoading();
    try {
      api.intent_guide(user.info.access_token, "find_hospital").then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            intentGuide = value.data!;
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
    page = 0;
    loadHospitalList();
  }

  void onScroll() {
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

  Future<bool> onIconPressed() async {
    //Navigator.of(context).pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
      isLoading: isLoading,
      isAvoidResize: false,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          var metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            if (metrics.pixels == 0) {
              print('At top');
            } else {
              print('At bottom');
              if (!isLast) {
                page = page + 1;
                loadHospitalList();
              }
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: LanguageService.trans("findhospital_hospitals_text1"),
                      style: AppTextStyle.PD(Colors.black, 20, weight: FW.bold, height: 1.5),
                    ),
                    TextSpan(
                      text: totals.toString(),
                      style: AppTextStyle.PD(AppColor_Primary, 20, weight: FW.bold, height: 1.5),
                    ),
                    TextSpan(
                      text: LanguageService.trans("gae"),
                      style: AppTextStyle.PD(Colors.black, 20, weight: FW.bold, height: 1.5),
                    ),
                    TextSpan(
                      text: LanguageService.trans("findhospital_hospitals_text"),
                      style: AppTextStyle.PD(Colors.black, 20, weight: FW.bold, height: 1.5),
                    ),
                  ]),
                ),
              ),
              Container(alignment: Alignment.centerLeft, padding: const EdgeInsets.fromLTRB(20, 10, 20, 10), child: H14(text: LanguageService.trans('findhospital_location_text'), align: TextAlign.left)),
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(border: Border.all(width: 1, color: AppColor_Tab_Unselected), borderRadius: BorderRadius.circular(10)),
                  child: Stack(alignment: Alignment.center, children: [
                    Align(alignment: Alignment.centerLeft, child: Container(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child: Image.asset('assets/place_black_24dp.png', width: 20))),
                    Center(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: keywordController,
                              textInputAction: TextInputAction.search,
                              maxLines: 1,
                              onEditingComplete: () {
                                page = 0;
                                hideKeyboard();
                                loadHospitalList();
                              },
                              onChanged: (text) {
                                setState(() {
                                  region = text;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "",
                                contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                hintStyle: AppTextStyle.PD(AppColor_Hint, 18, weight: FW.medium),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ))),
                    Align(alignment: Alignment.centerRight, child: Container(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child: Image.asset('assets/search_black_24dp.png', width: 20))),
                  ])),
              Container(
                height: 26,
                margin: const EdgeInsets.all(24.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int columnIndex) {
                    ServiceDto info = gStartInfo.hospital_services.elementAt(columnIndex);
                    return InkWell(
                      onTap: () {
                        speciality = info.short_name;
                        refresh();
                      },
                      child: Container(
                          height: 26,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: speciality == info.short_name ? const Color(0xFFF2F8FE) : Colors.white,
                            border: Border.all(width: 1, color: speciality == info.short_name ? AppColor_1A8DF0 : AppColor_Selector_Border),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                            child: H12(
                              text: info.short_name,
                              align: TextAlign.center,
                              weight: FW.semi_bold,
                              color: speciality == info.short_name ? AppColor_1A8DF0 : AppColor_36383C.withOpacity(0.6),
                            ),
                          )),
                    );
                  },
                  itemCount: gStartInfo.hospital_services.length,
                ),
              ),
              /*
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          speciality = "";
                          refresh();
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 30,
                            decoration: BoxDecoration(border: Border.all(width: 1, color: speciality == "" ? AppColor_Primary : AppColor_Gray), borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                LanguageService.trans('all') + " " + totalsWithFilter.toString(),
                                style: AppTextStyle.PD(speciality == "" ? AppColor_Primary : AppColor_GrayText, 14, weight: FW.medium, height: 1.0),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          speciality = "basic_treat";
                          refresh();
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 30,
                            decoration: BoxDecoration(border: Border.all(width: 1, color: speciality == "basic_treat" ? AppColor_Primary : AppColor_Gray), borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: H14(text: LanguageService.trans('basic_treat'), align: TextAlign.left, color: speciality == "basic_treat" ? AppColor_Primary : AppColor_GrayText),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          speciality = "nihon_kohden";
                          refresh();
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 30,
                            decoration: BoxDecoration(border: Border.all(width: 1, color: speciality == "nihon_kohden" ? AppColor_Primary : AppColor_Gray), borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: H14(text: LanguageService.trans('nihon_kohden'), align: TextAlign.left, color: speciality == "nihon_kohden" ? AppColor_Primary : AppColor_GrayText),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          speciality = "fujifilm";
                          refresh();
                        },
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 30,
                            decoration: BoxDecoration(border: Border.all(width: 1, color: speciality == "fujifilm" ? AppColor_Primary : AppColor_Gray), borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: H14(text: LanguageService.trans('fujifilm'), align: TextAlign.left, color: speciality == "fujifilm" ? AppColor_Primary : AppColor_GrayText),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              */
              Container(
                height: 26,
                margin: const EdgeInsets.only(bottom: 10, right: 24),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, SlideRightTransRoute(builder: (context) => MapHospitalPage(hospitalList: hospitalList)));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 72,
                      height: 26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: const Color(0xFF1A8DF0),
                      ),
                      child: Center(
                        child: H12(
                          text: LanguageService.trans('view_map'),
                          weight: FW.bold,
                          color: AppColor_White,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Stack(alignment: Alignment.center, children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: H14(
                          text: DateFormat('hh:mm').format(DateTime.now()) + " " + LanguageService.trans("update"),
                          weight: FW.bold,
                          align: TextAlign.left,
                          color: AppColor_Primary,
                        ))),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: refresh,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            H14(
                              text: LanguageService.trans("refresh"),
                              weight: FW.medium,
                              align: TextAlign.center,
                              color: AppColor_GrayText,
                            ),
                            const SizedBox(width: 10),
                            Image.asset('assets/ic_refresh.png', width: 25)
                          ],
                        ),
                      ),
                    ))
              ]),
              const SizedBox(height: 15),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: AppColor_GrayBackround,
                  height: 57,
                  child: H14(
                    text: intentGuide,
                    weight: FW.bold,
                    align: TextAlign.left,
                    color: AppColor_GrayText,
                  )),
              Container(
                  decoration: const BoxDecoration(
                    color: AppColor_GrayBackround,
                  ),
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FindHospitalItem(item: hospitalList[index]);
                        },
                        itemCount: hospitalList.length),
                  )),
              Container(
                height: hospitalList.isEmpty ? 300 : (hospitalList.length == 1 ? 200 : 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
