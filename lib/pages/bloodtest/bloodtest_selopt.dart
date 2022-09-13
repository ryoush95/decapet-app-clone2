import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/bt_dto.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/models/dto/schedules_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/bloodtest/payment.dart';
import 'package:decapet/pages/components/calendar1.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';

import 'bloodtest_complete.dart';
import 'bloodtest_select_hospital.dart';

class BloodTestAppSetOptPage extends StatefulWidget {
  List<int>? btIds;
  String? accidentYn;
  int? petId;
  HospitalDto? hospital;
  DateTime? date;
  String? time = "";
  int? reserveId;
  List<SchedulesDto>? list;
  List<SchedulesDto>? specialList;

  BloodTestAppSetOptPage({Key? key, this.btIds, this.accidentYn, this.petId, this.hospital, this.date, this.time, this.reserveId = 0, this.list, this.specialList}) : super(key: key) {
    this.hospital ??= HospitalDto();
    this.time ??= "00:00";
    this.accidentYn ??= "n";
    this.btIds ??= [];
    this.petId ??= 0;
    this.reserveId ??= 0;
  }

  @override
  BloodTestAppSetOptPageState createState() => BloodTestAppSetOptPageState();
}

class BloodTestAppSetOptPageState extends BaseState<BloodTestAppSetOptPage> {
  List<BtDto> btList = [];

  List<BtDto> feeList = [];
  List<BtDto> cbcList = [];
  List<BtDto> serumList = [];
  List<BtDto> electroList = [];
  List<BtDto> sdmaList = [];
  List<BtDto> proList = [];

  bool showDateBox = false;
  bool showTimeBox = false;
  bool agreeReserve = false;
  String payMethod = "";
  int point = 0;
  int totalMoney = 0;

  bool validStatus = false;

  List<SchedulesDto> schList = [];
  List<String> amTimes = [];
  List<String> pmTimes = [];
  var pointController = TextEditingController();

  @override
  void initState() {
    super.initState();
    schList = widget.list!;

    getBtList();
    if (widget.reserveId != 0) {
      getReservationDetail();
    } else {
      getTimes();
    }
  }

  void getReservationDetail() {
    showLoading();
    try {
      api.check_reservation(user.info.access_token, widget.reserveId!).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            HospitalDto _hospital = HospitalDto();
            _hospital.id = value.data!.hospital_id;
            _hospital.image = value.data!.image;
            _hospital.name = value.data!.name;
            _hospital.address = value.data!.address;
            _hospital.address_detail = value.data!.address_detail;

            widget.hospital = _hospital;
            widget.date = DateTime.parse(value.data!.reserve_dt);
            widget.time = value.data!.reserve_dt.substring(11, 16);
            value.data!.bt_items.split(",").forEach((element) {
              widget.btIds!.add(int.parse(element));
            });
            totalMoney = value.data!.list_price;
            point = value.data!.point;
            widget.petId = value.data!.pet_id;
            payMethod = value.data!.pay_method;

            pointController.text = point.toString();
            agreeReserve = true;
            checkValid();

            getTimes();
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

  void getTimes() {
    amTimes.clear();
    pmTimes.clear();

    if (widget.date == null) {
      return;
    }

    int wekk = widget.date!.weekday;
    String strWeek = "weekday";
    if (wekk == 6) {
      strWeek = "saturday";
    }

    if (wekk == 7) {
      strWeek = "sunday";
    }

    if (schList.isEmpty) {
      return;
    }

    SchedulesDto? info;
    for (int i = 0; i < schList.length; i++) {
      if (schList.elementAt(i).day_type == strWeek) {
        info = schList.elementAt(i);
        break;
      }
    }

    if (info == null) {
      return;
    }

    if (info.is_dayoff == "1") {
      //휴식일
      return;
    }

    int startHour = int.parse(info.start_time.split(":")[0]);
    int endHour = int.parse(info.end_time.split(":")[0]);
    for (int i = startHour; i < endHour + 1; i++) {
      if (i < 12) {
        if (i < 10) {
          if (!isExcept("0" + i.toString())) {
            amTimes.add("0" + i.toString() + ":00");
          }
        } else {
          if (!isExcept(i.toString())) {
            amTimes.add(i.toString() + ":00");
          }
        }
      } else {
        if (!isExcept(i.toString())) {
          pmTimes.add(i.toString() + ":00");
        }
      }
    }
    setState(() {});
  }

  bool isExcept(String hour) {
    if (widget.specialList!.isEmpty) {
      return false;
    }
    bool result = false;
    String makeDate = DateFormat('yyyy-MM-dd').format(widget.date!) + " " + hour;
    for (int i = 0; i < widget.specialList!.length; i++) {
      if (widget.specialList!.elementAt(i).start_time.contains(makeDate)) {
        return true;
      }
    }

    return result;
  }

  void getBtList() {
    showLoading();
    try {
      api.getBtItems(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          btList.addAll(value.data!.list);
          btList.forEach((element) {
            setState(() {
              if (widget.btIds!.contains(element.id)) {
                totalMoney += element.price;
              }
            });
          });
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
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  void onReselectHospital() {
    hideKeyboard();
    Future<dynamic> result = Navigator.push(
      context,
      SlideRightTransRoute(
        builder: (context) => BloodTestAppSelectHospitalPage(
          fromPath: "selopt",
        ),
      ),
    );

    result.then((res) {
      if (res != null) {
        HospitalDto _hospital = res as HospitalDto;
        setState(() {
          widget.hospital = _hospital;
        });
      }
    });
  }

  void onUseAllPoint() {
    setState(() {
      pointController.text = user.info.my_point.toString();
      point = user.info.my_point;
    });
  }

  void checkValid() {
    setState(() {
      validStatus = widget.hospital!.id != 0 && widget.btIds!.isNotEmpty && payMethod.isNotEmpty && agreeReserve && widget.date != null && widget.time != null && widget.time != "";
    });
  }

  void onReserve() {
    if (!validStatus) {
      return;
    }

    if (point > user.info.my_point) {
      showToast(LanguageService.trans("msg_exceeds_point"));
      return;
    }

    if (point > totalMoney) {
      showToast(LanguageService.trans("msg_exceeds_point_total_money"));
      return;
    }

    hideKeyboard();

    String reserveDt = getDateFormatString(widget.date!, "yyyy-MM-dd ") + widget.time!;
    showLoading();
    try {
      api.makeBloodTest(user.info.access_token, widget.btIds!.join(","), widget.hospital!.id, reserveDt, payMethod, totalMoney, point, user.info.phone_number, user.info.email, widget.petId!, widget.accidentYn!, widget.reserveId!).then((value) {
        hideLoading();
        if (value.result == 0) {
          Navigator.push(
            context,
            SlideRightTransRoute(
              builder: (context) => BloodTestAppCompletePage(animalType: value.data!.animal_type, reservationId: value.data!.reservation_id),
            ),
          );
          user.info.my_point = value.data!.point;
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void onReserve1() {
    if (!validStatus) {
      return;
    }

    if (point > 0 && point > user.info.my_point) {
      showToast(LanguageService.trans("msg_exceeds_point"));
      return;
    }

    if (point > totalMoney) {
      showToast(LanguageService.trans("msg_exceeds_point_total_money"));
      return;
    }

    hideKeyboard();

    String reserveDt = getDateFormatString(widget.date!, "yyyy-MM-dd ") + widget.time!;

    String merchantUid = "";
    if (payMethod == "card") {
      merchantUid = "merchant_" + DateTime.now().millisecondsSinceEpoch.toString() + "_1";
    } else if (payMethod == "bank") {
      merchantUid = "merchant_" + DateTime.now().millisecondsSinceEpoch.toString() + "_2";
    } else if (payMethod == "phone") {
      merchantUid = "merchant_" + DateTime.now().millisecondsSinceEpoch.toString() + "_3";
    }
    showLoading();
    try {
      api.payStart(user.info.access_token, widget.petId!, widget.hospital!.id, point, merchantUid, totalMoney, widget.btIds!.join(","), reserveDt).then((value) {
        hideLoading();
        if (value.result == 0) {
          user.info.my_point = user.info.my_point - point;
          Navigator.push(
            context,
            SlideRightTransRoute(
              builder: (context) => PaymentPage(payMethod: payMethod, merchantUid: merchantUid, totalMoney: totalMoney, point: point),
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

  void calcTotalMoney() {
    totalMoney = 0;
    btList.forEach((element) {
      setState(() {
        if (widget.btIds!.contains(element.id)) {
          totalMoney += element.price;
        }
      });
    });
  }

  void showReservePrivacy() {
    hideKeyboard();
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 150),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H20(
                  text: LanguageService.trans("product_terms"),
                  height: 1.5,
                  align: TextAlign.left,
                  maxLine: 2,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: InAppWebView(
                    gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                    initialOptions: InAppWebViewGroupOptions(
                        android: AndroidInAppWebViewOptions(useHybridComposition: true, textZoom: 50 * 2 // it makes 2 times bigger
                            )),
                    onLoadStart: (controller, url) => {
                      setState(() {
                        showLoading();
                      })
                    },
                    onLoadStop: (controller, url) => {
                      setState(() {
                        hideLoading();
                      })
                    },
                    initialUrlRequest: URLRequest(url: Uri.parse(PRODUCT_URL)),
                  ),
                ),
                const SizedBox(height: 20),
                MainTextButton(
                  height: 58,
                  backgroundColor: AppColor_Primary,
                  style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                  text: LanguageService.trans("do_agree"),
                  onPressed: () {
                    setState(() {
                      agreeReserve = true;
                    });
                    checkValid();
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
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
            title: LanguageService.trans("blood_test_app"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHospitalWidget(),
                  const SizedBox(height: 40),
                  _buildBtWidget(),
                  const SizedBox(height: 20),
                  Container(
                    color: Color(0xFFF8F9FA),
                    height: 10,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 40),
                  _buildDateTimeWidget(),
                  const SizedBox(height: 20),
                  Container(
                    color: Color(0xFFF8F9FA),
                    height: 10,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 40),
                  _buildPayWidget(),
                  const SizedBox(height: 40),
                  Container(
                    color: Color(0xFFF8F9FA),
                    height: 10,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 20),
                  _buildPriceWidget(),
                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (!agreeReserve) {
                                showReservePrivacy();
                              } else {
                                agreeReserve = false;
                              }
                            });
                            checkValid();
                          },
                          child: Image.asset(agreeReserve ? 'assets/ic_blue_check.png' : 'assets/ic_circle_off.png', height: 22),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: showReservePrivacy,
                          child: Text(
                            LanguageService.trans("product_terms"),
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.medium, height: 1, underline: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  InkWell(
                    child: Container(
                      color: !validStatus ? AppColor_Primary_Disable : AppColor_Primary,
                      height: 60,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          formatAmount(totalMoney - point) + LanguageService.trans("won") + " " + LanguageService.trans("pay"),
                          textAlign: TextAlign.center,
                          style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                        ),
                      ),
                    ),
                    onTap: onReserve1,
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
            image: NetworkImage(widget.hospital!.image),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ExtendedImage(
              image: AssetImage('assets/Component 3 – 1.png'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              onTap: onReselectHospital,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor_Primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: H14(
                    color: Colors.white,
                    text: LanguageService.trans("sel_hospital_again"),
                  ),
                ),
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
                  text: "[" + getGuName(widget.hospital!.address) + "]" + widget.hospital!.name,
                  weight: FW.bold,
                  color: Colors.white,
                ),
                const SizedBox(height: 5),
                H12(
                  text: widget.hospital!.address,
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

  Widget _buildBtWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: H20(
            text: LanguageService.trans("sel_opt"),
            height: 1.5,
            align: TextAlign.left,
          ),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF8F9FA)),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: feeList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.btIds!.contains(feeList[index].id)) {
                        widget.btIds!.remove(feeList[index].id);
                        totalMoney -= feeList[index].price;
                      } else {
                        widget.btIds!.add(feeList[index].id);
                        totalMoney += feeList[index].price;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(widget.btIds!.contains(feeList[index].id) ? 'assets/ic_black_check.png' : 'assets/ic_circle_off.png', height: 25),
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
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF2F8FE)),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cbcList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.btIds!.contains(cbcList[index].id)) {
                        widget.btIds!.remove(cbcList[index].id);
                        totalMoney -= cbcList[index].price;
                      } else {
                        widget.btIds!.add(cbcList[index].id);
                        totalMoney += cbcList[index].price;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(widget.btIds!.contains(cbcList[index].id) ? 'assets/ic_blue_check.png' : 'assets/ic_circle_off.png', height: 25),
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
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF2F8FE)),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: serumList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.btIds!.contains(serumList[index].id)) {
                        widget.btIds!.remove(serumList[index].id);
                        totalMoney -= serumList[index].price;
                      } else {
                        widget.btIds!.add(serumList[index].id);
                        totalMoney += serumList[index].price;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(widget.btIds!.contains(serumList[index].id) ? 'assets/ic_blue_check.png' : 'assets/ic_circle_off.png', height: 25),
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
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF2F8FE)),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: electroList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.btIds!.contains(electroList[index].id)) {
                        widget.btIds!.remove(electroList[index].id);
                        totalMoney -= electroList[index].price;
                      } else {
                        widget.btIds!.add(electroList[index].id);
                        totalMoney += electroList[index].price;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(widget.btIds!.contains(electroList[index].id) ? 'assets/ic_violett_check.png' : 'assets/ic_circle_off.png', height: 25),
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
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF2F8FE)),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: sdmaList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.btIds!.contains(sdmaList[index].id)) {
                        widget.btIds!.remove(sdmaList[index].id);
                        totalMoney -= sdmaList[index].price;
                      } else {
                        widget.btIds!.add(sdmaList[index].id);
                        totalMoney += sdmaList[index].price;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(widget.btIds!.contains(sdmaList[index].id) ? 'assets/ic_violett_check.png' : 'assets/ic_circle_off.png', height: 25),
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
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Color(0xFFF2F8FE)),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: proList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.btIds!.contains(proList[index].id)) {
                        widget.btIds!.remove(proList[index].id);
                        totalMoney -= proList[index].price;
                      } else {
                        widget.btIds!.add(proList[index].id);
                        totalMoney += proList[index].price;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(widget.btIds!.contains(proList[index].id) ? 'assets/ic_violett_check.png' : 'assets/ic_circle_off.png', height: 25),
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
    );
  }

  Widget _buildDateTimeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: H20(
            text: LanguageService.trans("date_time"),
            height: 1.5,
            align: TextAlign.left,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 25,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/date_range_black_24dp.png', width: 25),
              const SizedBox(width: 5),
              Expanded(
                child: H20(
                  align: TextAlign.left,
                  text: widget.date == null ? LanguageService.trans("select_date") : getDateFormatString(widget.date!, "MMMMEEEEd"),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showDateBox = !showDateBox;
                  });
                },
                child: Container(
                  height: 30,
                  transform: Matrix4.translationValues(0, !showDateBox ? 25 : 0, 0),
                  child: Container(
                    transform: Matrix4.rotationX(!showDateBox ? 3.14 : 0),
                    child: Image.asset(
                      'assets/expand_circle_down_black_24dp.png',
                      width: 30,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: showDateBox,
          child: Column(
            children: [
              AppCalendar1(
                current: widget.date,
                onDateSelected: (datetime) {
                  setState(() {
                    widget.date = datetime;
                    widget.time = "";
                    getTimes();
                    checkValid();
                  });
                },
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(children: [
                    Expanded(child: Container()),
                    Image.asset('assets/icon_check_on.png', height: 17),
                    const SizedBox(width: 8),
                    H14(text: LanguageService.trans("sel"), weight: FW.medium, color: AppColor_36383C.withOpacity(0.4)),
                    const SizedBox(width: 10),
                    Image.asset('assets/icon_check_off.png', height: 17),
                    const SizedBox(width: 8),
                    H14(text: LanguageService.trans("non"), weight: FW.medium, color: AppColor_36383C.withOpacity(0.4))
                  ])),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: Color(0xFFF8F9FA),
          height: 1,
          width: double.infinity,
        ),
        const SizedBox(height: 20),
        Container(
          height: 25,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ic_time.png',
                width: 25,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: H20(
                  align: TextAlign.left,
                  text: widget.time!.isEmpty ? LanguageService.trans("time_select") : getDateFormatString(DateTime.parse("2020-02-02 " + widget.time!), "a HH:mm"),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showTimeBox = !showTimeBox;
                  });
                },
                child: Container(
                  height: 30,
                  transform: Matrix4.translationValues(0, !showTimeBox ? 25 : 0, 0),
                  child: Container(
                    transform: Matrix4.rotationX(!showTimeBox ? 3.14 : 0),
                    child: Image.asset(
                      'assets/expand_circle_down_black_24dp.png',
                      width: 30,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: showTimeBox,
          child: Column(
            children: [
              // TimeSelector(
              //     time: widget.time,
              //     onSelectTime: (_time) {
              //       setState(() {
              //         widget.time = _time;
              //       });
              //     }),
              Center(
                  child: H18(
                text: LanguageService.trans("AM"),
                weight: FW.medium,
                align: TextAlign.center,
              )),
              Container(
                height: getAmHeight(),
                margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  crossAxisCount: 4,
                  childAspectRatio: ((MediaQuery.of(context).size.width - 48 - 18) / 4) / 43,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  children: _getAmTiles(),
                ),
              ),
              SizedBox(height: 40),
              Center(
                  child: H18(
                text: LanguageService.trans("PM"),
                align: TextAlign.center,
                weight: FW.medium,
              )),
              Container(
                height: getPmHeight(),
                margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 32),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  crossAxisCount: 4,
                  childAspectRatio: ((MediaQuery.of(context).size.width - 48 - 18) / 4) / 43,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  children: _getPmTiles(),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    //SizedBox(width: 200,),
                    Expanded(child: Container()),
                    Image.asset('assets/icon_check_on.png', height: 17),
                    const SizedBox(width: 8),
                    H14(text: LanguageService.trans("sel"), weight: FW.medium, color: AppColor_36383C.withOpacity(0.4)),
                    const SizedBox(width: 10),
                    Image.asset('assets/icon_check_off.png', height: 17),
                    const SizedBox(width: 8),
                    H14(text: LanguageService.trans("non"), weight: FW.medium, color: AppColor_36383C.withOpacity(0.4))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPayItem(type) {
    String methodImage = "";
    String payType = "";
    switch (type) {
      case "card":
        methodImage = "assets/payment_black_24dp.png";
        payType = LanguageService.trans("card_pay");
        break;
      case "bank":
        methodImage = "assets/savings_black_24dp1.png";
        payType = LanguageService.trans("bank_transfer");
        break;
      case "phone":
        methodImage = "assets/phone_iphone_black_24dp.png";
        payType = LanguageService.trans("phone_pay");
        break;
    }

    double _height = MediaQuery.of(context).size.width / 4;
    double _width = MediaQuery.of(context).size.width / 4;
    return InkWell(
      onTap: () {
        setState(() {
          payMethod = type;
        });
        checkValid();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all(color: payMethod == type ? AppColor_Primary : Colors.transparent)),
        height: _height,
        width: _width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(methodImage, height: 25),
              const SizedBox(height: 10),
              Text(
                payType,
                textAlign: TextAlign.center,
                style: AppTextStyle.PD(Colors.black54, 16, weight: FW.medium),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPayWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: H20(
            text: LanguageService.trans("paymethod"),
            height: 1.5,
            align: TextAlign.left,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          color: Color(0xFFF8F9FA),
          height: 1,
          width: double.infinity,
        ),
        Row(
          children: [
            _buildPayItem("card"),
            _buildPayItem("bank"),
            _buildPayItem("phone"),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: Color(0xFFF8F9FA),
          height: 1,
          width: double.infinity,
        )
      ],
    );
  }

  Widget _buildPriceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: H20(
            text: LanguageService.trans("points_use"),
            height: 1.5,
            align: TextAlign.left,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: pointController,
                  style: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.medium),
                  onEditingComplete: () {},
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.unspecified,
                  maxLines: 1,
                  onChanged: (_str) {
                    int _point = _str.isEmpty ? 0 : int.parse(_str);
                    setState(() {
                      point = _point;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintText: "",
                    hintStyle: AppTextStyle.PD(AppColor_Hint, 18, weight: FW.medium),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFedeeef)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xFFedeeef)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: onUseAllPoint,
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), border: Border.all(color: AppColor_Primary)),
                  child: Center(
                    child: H16(
                      text: LanguageService.trans("all_use"),
                      color: AppColor_Primary,
                      weight: FW.medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              H16(text: LanguageService.trans("use_point"), weight: FW.medium),
              SizedBox(width: 30),
              H16(text: formatAmount(user.info.my_point) + LanguageService.trans("p"), color: AppColor_Primary, weight: FW.medium),
            ],
          ),
        ),
        const SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H16(text: LanguageService.trans("all_money"), weight: FW.medium),
              H16(text: formatAmount(totalMoney) + LanguageService.trans("won"), weight: FW.medium),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H16(text: LanguageService.trans("point_apply_down"), weight: FW.medium),
              H16(text: "-" + formatAmount(point) + LanguageService.trans("won"), weight: FW.medium),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: Color(0xFFF8F9FA),
          height: 1,
          width: double.infinity,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H20(text: LanguageService.trans("final_paymoney"), weight: FW.medium),
              H20(text: formatAmount(totalMoney - point) + LanguageService.trans("won"), color: AppColor_Primary),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  double getAmHeight() {
    if (amTimes.length == 0) {
      return 0;
    }

    int count = amTimes.length ~/ 4;
    int mod = amTimes.length % 4;
    if (mod != 0) {
      count = count + 1;
    }
    int height = 43 * count + 6 * (count - 1);
    return height.toDouble();
  }

  double getPmHeight() {
    if (pmTimes.length == 0) {
      return 0;
    }

    int count = pmTimes.length ~/ 4;
    int mod = pmTimes.length % 4;
    if (mod != 0) {
      count = count + 1;
    }
    int height = 43 * count + 6 * (count - 1);
    return height.toDouble();
  }

  //am grid tile
  List<Widget> _getAmTiles() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < amTimes.length; i++) {
      tiles.add(GridTile(
          child: InkWell(
        onTap: () {
          widget.time = amTimes[i];
          checkValid();
          setState(() {});
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 43,
          decoration: BoxDecoration(color: widget.time == amTimes[i] ? Color(0xFF1A8DF0) : Color(0xFFF2F8FE), borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Center(
              child: H18(
            text: amTimes[i],
            color: widget.time == amTimes[i] ? Colors.white : AppColor_36383C,
            weight: FW.medium,
            align: TextAlign.center,
          )),
        ),
      )));
    }
    return tiles;
  }

  //am grid tile
  List<Widget> _getPmTiles() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < pmTimes.length; i++) {
      tiles.add(GridTile(
          child: InkWell(
        onTap: () {
          widget.time = pmTimes[i];
          checkValid();
          setState(() {});
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 43,
          decoration: BoxDecoration(color: widget.time == pmTimes[i] ? Color(0xFF1A8DF0) : Color(0xFFF2F8FE), borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Center(
              child: H18(
            text: pmTimes[i],
            color: widget.time == pmTimes[i] ? Colors.white : AppColor_36383C,
            weight: FW.medium,
            align: TextAlign.center,
          )),
        ),
      )));
    }
    return tiles;
  }
}
