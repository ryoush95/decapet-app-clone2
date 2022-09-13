import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/hospital/hospital_detail_header.dart';
import 'package:decapet/pages/hospital/hospital_reserve.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FindHospitalItem extends StatefulWidget {
  final HospitalDto item;

  FindHospitalItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  FindHospitalItemState createState() => FindHospitalItemState();
}

class FindHospitalItemState extends BaseState<FindHospitalItem> {
  Future<void> phoneCall() async {
    String url = "tel://" + widget.item.phone_number;
    String phone = widget.item.phone_number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phone';
    }
  }

  void onReserve() {
    // showModalBottomSheet(
    //     backgroundColor: Colors.transparent,
    //     context: context,
    //     builder: (context) {
    //       return HospitalReserveDialog(item: widget.item);
    //     });
    Navigator.push(context, SlideRightTransRoute(builder: (context) => HospitalReserve(hospital: widget.item)));
  }

  void goHospitalInfo() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => HospitalDetailHeader(item: widget.item)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColor_White,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.center, children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: H14(
                      text: LanguageService.trans(widget.item.name),
                      weight: FW.bold,
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
              const SizedBox(width: 10),
              H14(text: widget.item.like_cnt.toString(), color: AppColor_Primary),
              const SizedBox(width: 20),
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
          Visibility(
            visible: widget.item.speciality.isNotEmpty,
            child: Container(
              height: 30,
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: widget.item.reserve_yn == 'n' ? AppColor_Intro_Description : AppColor_Primary),
                        child: Center(
                          child: H14(
                            text: widget.item.reserve_yn == 'n' ? LanguageService.trans("tel") : LanguageService.trans("reserve"),
                            weight: FW.semi_bold,
                            align: TextAlign.center,
                            color: AppColor_White,
                          ),
                        ),
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          goHospitalInfo();
                        },
                        child: Container(
                          height: 34,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor_Selector_Border.withOpacity(0.5)),
                          child: Center(
                            child: H14(
                              text: LanguageService.trans("Hospital_Info"),
                              weight: FW.semi_bold,
                              align: TextAlign.center,
                              color: AppColor_BlackText,
                            ),
                          ),
                        )))
              ])),
          const AppDivider(height: 1.0, color: AppColor_Gray)
        ],
      ),
    );
  }
}
