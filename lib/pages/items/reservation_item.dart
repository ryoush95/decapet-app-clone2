import 'dart:ui';

import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/reservation_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class ReservationItem extends StatefulWidget {
  ReservationDto reservation;
  String? datePassStatus;
  final onCheckReservation;
  final onCancelReservation;
  final onChangeReservation;

  ReservationItem({required this.reservation, required this.datePassStatus, required this.onCancelReservation, required this.onCheckReservation, this.onChangeReservation});

  @override
  ReservationItemState createState() => ReservationItemState();
}

class ReservationItemState extends BaseState<ReservationItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onCheckReservation(widget.reservation.id);
      },
      child: Column(
        children: [
          // const SizedBox(height: 5),
          Container(
            color: AppColor_Divider,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
            child: Container(
              // color: AppColor_White,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppColor_Gray,
                  blurRadius: 5.0, // soften the shadow
                )
              ], borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20), topRight: Radius.circular(20)), color: Colors.white),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/blood.png", width: 50),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          H14(
                            color: AppColor_Red,
                            text: LanguageService.trans('blood_draw'),
                            align: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          H16(
                            color: AppColor_BlackText,
                            text: widget.reservation.name,
                            weight: FW.medium,
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Visibility(
                        visible: widget.reservation.diff_days > 0,
                        child: H14(color: AppColor_BlackText, text: LanguageService.trans('d') + "-" + widget.reservation.diff_days.toString()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 1,
                    color: AppColor_Selector_Border,
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: widget.datePassStatus == "false" && widget.reservation.pay_status == "paid",
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: H12(
                        color: AppColor_BlackText,
                        text: sprintf("%s %s", [getDateFormatString(DateTime.parse(widget.reservation.reserve_dt), "yyyy-MM-dd HH:mm"), LanguageService.trans('making_treatment')]),
                        align: TextAlign.left,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.datePassStatus == "true" && widget.reservation.pay_status == "paid",
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: H12(
                        color: AppColor_BlackText,
                        text: sprintf("%s %s", [getDateFormatString(DateTime.parse(widget.reservation.reserve_dt), "yyyy-MM-dd HH:mm"), " 방문했어요."]),
                        align: TextAlign.left,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.reservation.pay_status == "cancelled",
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          H12(
                            color: AppColor_BlackText,
                            text: sprintf("%s %s", [getDateFormatString(DateTime.parse(widget.reservation.reserve_dt), "yyyy-MM-dd HH:mm"), " 예약을 "]),
                            align: TextAlign.left,
                          ),
                          H12(
                            color: Color(0xFFFF3E3E),
                            text: "취소",
                            align: TextAlign.left,
                          ),
                          H12(
                            color: AppColor_BlackText,
                            text: "했어요.",
                            align: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: widget.datePassStatus == "true", //widget.reservation.diff_days <= 0,
                    child: MainTextButton(
                      height: 40,
                      text: LanguageService.trans("check_reservatin_detail"),
                      backgroundColor: AppColor_Selector_Border,
                      radius: 5,
                      style: AppTextStyle.PD(Colors.black, 14, weight: FW.bold),
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        widget.onCheckReservation(widget.reservation.id);
                      },
                    ),
                  ),
                  Visibility(
                    visible: widget.datePassStatus == "false" && widget.reservation.pay_status == "paid",
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expanded(
                        //   child: InkWell(
                        //     onTap: () {
                        //       widget.onChangeReservation(widget.reservation.id);
                        //     },
                        //     child: Container(
                        //       padding: EdgeInsets.symmetric(horizontal: 5),
                        //       decoration: BoxDecoration(color: const Color.fromARGB(255, 26, 141, 240), borderRadius: BorderRadius.circular(6)),
                        //       height: 35,
                        //       child: Center(
                        //         child: Text(
                        //           LanguageService.trans("change_reservation"),
                        //           style: AppTextStyle.PD(Colors.white, 14, weight: FW.semi_bold),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              widget.onCancelReservation(widget.reservation.id);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(color: AppColor_Selector_Border, borderRadius: BorderRadius.circular(6)),
                              height: 35,
                              child: Center(
                                child: Text(
                                  LanguageService.trans("cancel_reservation"),
                                  style: AppTextStyle.PD(Colors.black, 14, weight: FW.semi_bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
