import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/models/dto/schedules_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/calendar1.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

import 'bloodtest_selopt.dart';

class BloodTestSelectDateTimePage extends StatefulWidget {
  List<int> btIds;
  final String accidentYn;
  final int petId;
  final HospitalDto hospital;

  BloodTestSelectDateTimePage({Key? key, required this.btIds, required this.accidentYn, required this.petId, required this.hospital}) : super(key: key);

  @override
  BloodTestSelectDateTimePageState createState() => BloodTestSelectDateTimePageState();
}

class BloodTestSelectDateTimePageState extends BaseState<BloodTestSelectDateTimePage> {
  DateTime? date;
  String time = "";

  String buttonText = LanguageService.trans("text_select_date_time");
  bool showDateBox = true;
  bool showTimeBox = true;
  List<SchedulesDto> schList = [];
  List<SchedulesDto> specialList = [];
  List<String> amTimes = [];
  List<String> pmTimes = [];
  @override
  void initState() {
    super.initState();

    getHospitalSchInfo();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void getHospitalSchInfo() {
    showLoading();
    try {
      api.hosiptalSchInfo(user.info.access_token, widget.hospital.id).then((value) {
        hideLoading();
        if (value.result == 0) {
          schList = value.data!.list;
          specialList = value.data!.special;
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
    time = "";

    int wekk = date!.weekday;
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
    if (specialList.isEmpty) {
      return false;
    }
    bool result = false;
    String makeDate = DateFormat('yyyy-MM-dd').format(date!) + " " + hour;
    for (int i = 0; i < specialList.length; i++) {
      if (specialList.elementAt(i).start_time.contains(makeDate)) {
        return true;
      }
    }

    return result;
  }

  void onNext() {
    if (date == null || time.isEmpty) {
      return;
    }
    Navigator.push(
      context,
      SlideRightTransRoute(
        builder: (context) => BloodTestAppSetOptPage(
          petId: widget.petId,
          btIds: widget.btIds,
          accidentYn: widget.accidentYn,
          hospital: widget.hospital,
          date: date,
          time: time,
          list: schList,
          specialList: specialList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans('blood_test_app'),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/date_range_black_24dp.png', width: 25),
                        const SizedBox(width: 5),
                        H20(
                          align: TextAlign.left,
                          text: date == null
                              ? LanguageService.trans("select_date")
                              : getDateFormatString(today, "MMMMd") != getDateFormatString(date!, "MMMMd")
                                  ? getDateFormatString(date!, "MMMMEEEEd")
                                  : getDateFormatString(date!, "MMMMd"),
                        ),
                        Visibility(
                          visible: date != null && getDateFormatString(today, "MMMMd") == getDateFormatString(date!, "MMMMd"),
                          child: H20(
                            align: TextAlign.left,
                            text: " " + LanguageService.trans('today'),
                            color: AppColor_Red,
                          ),
                        ),
                        Expanded(child: Container()),
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
                          current: date,
                          onDateSelected: (datetime) {
                            setState(() {
                              date = datetime;
                              getTimes();
                              buttonText = (date == null || time.isEmpty) ? LanguageService.trans("text_select_date_time") : sprintf("%s,%s", [getDateFormatString(date!, "yyyy/MMMM/dd(EEEE)"), getDateFormatString(DateTime.parse("2020-02-02 " + time), "a HH:mm")]);
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 8,
                    color: Color(0xFFF8F9FA),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: H20(
                            align: TextAlign.left,
                            text: time.isEmpty ? LanguageService.trans("time_select") : getDateFormatString(DateTime.parse("2020-02-02 " + time), "a HH:mm"),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: showTimeBox,
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          color: AppColor_Selector_Border,
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // TimeSelector(onSelectTime: (_time) {
                        //   setState(() {
                        //     time = _time;
                        //     buttonText = (date == null || time.isEmpty) ? LanguageService.trans("text_select_date_time") : sprintf("%s,%s", [getDateFormatString(date!, "yyyy/MMMM/dd(EEEE)"), getDateFormatString(DateTime.parse("2020-02-02 " + time), "a HH:mm")]);
                        //   });
                        // }),
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
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              color: date == null || time.isEmpty ? AppColor_Primary_Disable : AppColor_Primary,
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
            onTap: onNext,
          ),
        ],
      ),
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
          time = amTimes[i];
          buttonText = (date == null || time.isEmpty) ? LanguageService.trans("text_select_date_time") : sprintf("%s,%s", [getDateFormatString(date!, "yyyy/MMMM/dd(EEEE)"), getDateFormatString(DateTime.parse("2020-02-02 " + time), "a HH:mm")]);
          setState(() {});
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 43,
          decoration: BoxDecoration(color: time == amTimes[i] ? Color(0xFF1A8DF0) : Color(0xFFF2F8FE), borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Center(
              child: H18(
            text: amTimes[i],
            color: time == amTimes[i] ? Colors.white : AppColor_36383C,
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
          time = pmTimes[i];
          buttonText = (date == null || time.isEmpty) ? LanguageService.trans("text_select_date_time") : sprintf("%s,%s", [getDateFormatString(date!, "yyyy/MMMM/dd(EEEE)"), getDateFormatString(DateTime.parse("2020-02-02 " + time), "a HH:mm")]);
          setState(() {});
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 43,
          decoration: BoxDecoration(color: time == pmTimes[i] ? Color(0xFF1A8DF0) : Color(0xFFF2F8FE), borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Center(
              child: H18(
            text: pmTimes[i],
            color: time == pmTimes[i] ? Colors.white : AppColor_36383C,
            weight: FW.medium,
            align: TextAlign.center,
          )),
        ),
      )));
    }
    return tiles;
  }
}
