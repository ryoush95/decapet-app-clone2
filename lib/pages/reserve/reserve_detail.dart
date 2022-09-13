import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/reservation_dto.dart';
import 'package:decapet/models/dto/schedules_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/bloodtest/bloodtest_selopt.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../components/simple_header.dart';

class ReserveDetailPage extends StatefulWidget {
  int reservationId;
  String? datePassStatus;
  List<SchedulesDto>? list;

  ReserveDetailPage({Key? key, required this.reservationId, required this.datePassStatus, required this.list}) : super(key: key);

  @override
  ReserveDetailPageState createState() => ReserveDetailPageState();
}

class ReserveDetailPageState extends BaseState<ReserveDetailPage> {
  var reservation = ReservationDto();
  String guName = "";

  @override
  void initState() {
    super.initState();

    getReservationDetail();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return true;
  }

  void getReservationDetail() {
    showLoading();
    try {
      api.check_reservation(user.info.access_token, widget.reservationId).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            reservation = value.data!;
            guName = getGuName(reservation.address);
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

  void onChangeReservation(reservationId) {
    Navigator.push(
      context,
      SlideRightTransRoute(
        builder: (context) => BloodTestAppSetOptPage(reserveId: reservationId),
      ),
    );
  }

  void onCancelReservation1(int _id) {
    showLoading();
    try {
      api.cancelReservation(user.info.access_token, _id).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            showToast(LanguageService.trans("reserve_cancel_success"));
            Navigator.pop(context, "200");
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

  void onCancelReservation(reservationId) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H20(text: LanguageService.trans('cancel_reservation'), height: 1.5),
                    InkWell(
                      child: H20(
                        text: LanguageService.trans('close'),
                        weight: FW.medium,
                        color: AppColor_Primary,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              H18(text: LanguageService.trans("msg_confirm_reserve_cancel")),
              const SizedBox(height: 50),
              MainTextButton(
                text: LanguageService.trans('cancel_reservation'),
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancelReservation1(reservationId);
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans("check_your_reservation_details"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHospitalWidget(),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            H14(
                              text: LanguageService.trans("blood_draw"),
                              weight: FW.bold,
                              align: TextAlign.left,
                              color: AppColor_Red,
                            ),
                            const SizedBox(width: 20),
                            Visibility(
                              visible: true,
                              child: H14(color: AppColor_BlackText, text: getDateFormatString(DateTime.parse(reservation.reserve_dt), "yyyy-MM-dd HH:mm, ") + LanguageService.trans('d') + "-" + reservation.diff_days.toString()),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        H14(
                          text: "[" + guName + "] " + reservation.name,
                          weight: FW.medium,
                          align: TextAlign.left,
                          color: AppColor_GrayText,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: Color(0xFFF8F9FA),
                          height: 5,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
                        H18(
                          text: LanguageService.trans('Inspection_items'),
                          weight: FW.bold,
                          align: TextAlign.left,
                          color: AppColor_BlackText,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          reservation.bt_items_text,
                          style: AppTextStyle.PD(AppColor_Input_Title, 14, height: 1.2),
                          textAlign: TextAlign.left,
                          maxLines: null,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 5,
                          color: AppColor_GrayBackround,
                        ),
                        const SizedBox(height: 20),
                        H18(
                          text: LanguageService.trans('Payment_history'),
                          weight: FW.bold,
                          align: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            H14(
                              text: LanguageService.trans("total_amount"),
                              weight: FW.semi_bold,
                              color: AppColor_Input_Title,
                            ),
                            H14(
                              text: formatAmount(reservation.list_price) + LanguageService.trans("won"),
                              weight: FW.semi_bold,
                              color: AppColor_Input_Title,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            H14(
                              text: LanguageService.trans("discount_with_points"),
                              weight: FW.semi_bold,
                              color: AppColor_Input_Title,
                            ),
                            H14(
                              text: "-" + formatAmount(reservation.point) + LanguageService.trans("won"),
                              weight: FW.semi_bold,
                              color: AppColor_Input_Title,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: Color(0xFFF8F9FA),
                          height: 1,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            H18(
                              text: LanguageService.trans('final_payment_amount'),
                              weight: FW.medium,
                              color: AppColor_BlackText,
                              align: TextAlign.left,
                            ),
                            H18(
                              text: formatAmount(reservation.price) + LanguageService.trans("won"),
                              weight: FW.bold,
                              color: AppColor_Primary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        H18(
                          text: LanguageService.trans("payment_method"),
                          color: AppColor_BlackText,
                        ),
                        const SizedBox(height: 10),
                        H14(
                          text: reservation.pay_method == "card" ? LanguageService.trans("card_pay") : (reservation.pay_method == "bank" ? LanguageService.trans("bank_transfer") : LanguageService.trans("phone_pay")),
                          weight: FW.semi_bold,
                          color: AppColor_Input_Title,
                        ),
                        const SizedBox(height: 40),
                        Visibility(
                          visible: reservation.diff_days == 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor_GrayBackround,
                              ),
                              child: H18(
                                text: LanguageService.trans("today_reservation_hint"),
                                weight: FW.bold,
                                color: AppColor_Input_Title,
                                align: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          // visible: reservation.diff_days > 0,
                          visible: widget.datePassStatus == "false" && reservation.pay_status == "paid",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // MainTextButton(
                              //   height: 58,
                              //   text: LanguageService.trans("change_reservation"),
                              //   backgroundColor: const Color.fromARGB(255, 26, 141, 240),
                              //   style: AppTextStyle.PD(Colors.white, 18, weight: FW.semi_bold),
                              //   width: 150,
                              //   onPressed: () {
                              //     onChangeReservation(widget.reservationId);
                              //   },
                              // ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              MainTextButton(
                                height: 58,
                                text: LanguageService.trans("cancel_reservation"),
                                backgroundColor: AppColor_Selector_Border,
                                style: AppTextStyle.PD(Colors.black, 18, weight: FW.semi_bold),
                                width: 200,
                                onPressed: () {
                                  onCancelReservation(widget.reservationId);
                                },
                              ),
                            ],
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

  Widget _buildHospitalWidget() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          ExtendedImage(
            image: NetworkImage(reservation.image),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black87,
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
                stops: [0.0, 0.7],
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H14(
                  text: "[" + guName + "]" + reservation.name,
                  weight: FW.bold,
                  color: Colors.white,
                ),
                const SizedBox(height: 5),
                H12(
                  text: reservation.address_detail,
                  weight: FW.medium,
                  align: TextAlign.left,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
