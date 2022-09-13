import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

import 'hospital_detail_header.dart';
import 'hospital_reserve.dart';

class HospitalReserveDialog extends StatefulWidget {
  HospitalDto item;
  HospitalReserveDialog({Key? key, required this.item}) : super(key: key);

  @override
  HospitalReserveDialogState createState() => HospitalReserveDialogState();
}

class HospitalReserveDialogState extends State<HospitalReserveDialog> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.pop(context);
    return true;
  }

  void onReserve() {
    Navigator.pop(context);
    Navigator.push(context, SlideRightTransRoute(builder: (context) => HospitalReserve(hospital: widget.item)));
  }

  void onHospitalInfo() {
    Navigator.pop(context);
    Navigator.push(context, SlideRightTransRoute(builder: (context) => HospitalDetailHeader(item: widget.item)));
  }

  Future<void> phoneCall() async {
    String url = "tel://" + widget.item.phone_number;
    String phone = widget.item.phone_number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return WillPopScope(
        onWillPop: onBackPressed,
        child: Container(
          height: 280,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //     padding: const EdgeInsets.symmetric(vertical: 20),
                //     child: H20(
                //       text: LanguageService.trans("Reserve_Possible"),
                //       weight: FW.bold,
                //       align: TextAlign.left,
                //       color: AppColor_BlackText,
                //     )),
                Container(
                  height: 35,
                ),
                Stack(alignment: Alignment.center, children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: H16(
                            text: widget.item.name,
                            weight: FW.semi_bold,
                            align: TextAlign.left,
                            color: AppColor_BlackText,
                          ))),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Visibility(
                        visible: widget.item.like_yn == 'y' ? true : false,
                        child: Image.asset('assets/ic_like_on.png', width: 20),
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Visibility(
                        visible: widget.item.like_yn == 'y' ? false : true,
                        child: Image.asset('assets/ic_red_heart_off.png', width: 20),
                      ))
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/ic_like_on.png', width: 20),
                    SizedBox(width: 10),
                    H14(text: widget.item.like_cnt.toString(), color: AppColor_Primary),
                    SizedBox(width: 20),
                    H14(
                      text: LanguageService.trans("findhospital_Review"),
                      color: AppColor_GrayText,
                    ),
                    const SizedBox(width: 10),
                    H14(text: widget.item.review_cnt.toString(), color: AppColor_GrayText),
                    SizedBox(width: 20),
                    H14(text: double.parse(widget.item.distance).toStringAsFixed(2) + ' km', color: AppColor_Red),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  height: 30,
                  child: Visibility(
                    visible: isSpecialityCnt(widget.item.speciality),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              decoration: BoxDecoration(border: Border.all(width: 1, color: AppColor_Gray), borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: H14(text: LanguageService.trans(widget.item.speciality.split(',')[index]), align: TextAlign.left, color: AppColor_GrayText),
                              ));
                        },
                        itemCount: widget.item.speciality.split(',').length),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              if (widget.item.reserve_yn == 'n') {
                                phoneCall();
                              } else {
                                onReserve();
                              }
                            },
                            child: Container(
                              height: 34,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor_Primary),
                              child: Center(
                                child: H14(
                                  text: widget.item.reserve_yn == 'n' ? LanguageService.trans("tel") : LanguageService.trans("reserve"),
                                  weight: FW.bold,
                                  align: TextAlign.center,
                                  color: AppColor_White,
                                ),
                              ),
                            )),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                onHospitalInfo();
                              },
                              child: Container(
                                height: 34,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColor_Selector_Border.withOpacity(0.5)),
                                child: Center(
                                  child: H14(
                                    text: LanguageService.trans("Hospital_Info"),
                                    weight: FW.bold,
                                    align: TextAlign.center,
                                    color: AppColor_BlackText,
                                  ),
                                ),
                              )))
                    ]))
              ],
            ),
          ]),
        ),
      );
    });
  }

  bool isSpecialityCnt(String speciality) {
    List<String> arr = widget.item.speciality.split(',');
    if (arr.isEmpty) {
      return false;
    }

    if (arr[0] == "") {
      return false;
    }
    return true;
  }
}
