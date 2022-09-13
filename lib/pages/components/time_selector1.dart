import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/time_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeSelector1 extends StatefulWidget {
  String? time;
  final void Function(String) onSelectTime;

  TimeSelector1({Key? key, required this.onSelectTime, this.time}) : super(key: key);

  @override
  TimeSelector1State createState() => TimeSelector1State();
}

class TimeSelector1State extends State<TimeSelector1> {
  double? button_width = 80;
  double? button_height = 40;
  List<bool> state_list = [];
  List<String> time_list = [];

  @override
  void initState() {
    super.initState();
    time_list.add("10:00");
    time_list.add("11:00");
    time_list.add("12:00");
    time_list.add("13:00");
    time_list.add("14:00");
    time_list.add("15:00");
    time_list.add("16:00");
    time_list.add("17:00");
    time_list.add("18:00");
    time_list.add("19:00");
    time_list.add("20:00");
    time_list.add("21:00");

    for (int i = 0; i < 12; i++) {
      if (time_list[i] == widget.time) {
        state_list.add(true);
      } else {
        state_list.add(false);
      }
    }
  }

  void clearStates() {
    for (int i = 0; i < 12; i++) state_list[i] = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: H18(
            text: LanguageService.trans("AM"),
            weight: FW.medium,
            align: TextAlign.center,
          )),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TimeButton(
                      text: time_list[0],
                      backgroundColor: AppColor_Primary,
                      active: state_list[0],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[0] = true;
                        });
                        widget.onSelectTime(time_list[0]);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TimeButton(
                      text: time_list[1],
                      backgroundColor: AppColor_Primary,
                      active: state_list[1],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[1] = true;
                        });
                        widget.onSelectTime(time_list[1]);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(width: button_width),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(width: button_width),
                  ),
                ],
              )),
          SizedBox(height: 20),
          Center(
              child: H18(
            text: LanguageService.trans("PM"),
            align: TextAlign.center,
            weight: FW.medium,
          )),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TimeButton(
                      text: time_list[2],
                      backgroundColor: AppColor_Primary,
                      active: state_list[2],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[2] = true;
                        });
                        widget.onSelectTime(time_list[2]);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TimeButton(
                      text: time_list[3],
                      backgroundColor: AppColor_Primary,
                      active: state_list[3],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[3] = true;
                        });
                        widget.onSelectTime(time_list[3]);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TimeButton(
                      text: time_list[4],
                      backgroundColor: AppColor_Primary,
                      active: state_list[4],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[4] = true;
                        });
                        widget.onSelectTime(time_list[4]);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TimeButton(
                      text: time_list[5],
                      backgroundColor: AppColor_Primary,
                      active: state_list[5],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[5] = true;
                        });
                        widget.onSelectTime(time_list[5]);
                      },
                    ),
                  ),
                ],
              )),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TimeButton(
                      text: time_list[6],
                      backgroundColor: AppColor_Primary,
                      active: state_list[6],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[6] = true;
                        });
                        widget.onSelectTime(time_list[6]);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TimeButton(
                      text: time_list[7],
                      backgroundColor: AppColor_Primary,
                      active: state_list[7],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[7] = true;
                        });
                        widget.onSelectTime(time_list[7]);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TimeButton(
                      text: time_list[8],
                      backgroundColor: AppColor_Primary,
                      active: state_list[8],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[8] = true;
                        });
                        widget.onSelectTime(time_list[8]);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TimeButton(
                      text: time_list[9],
                      backgroundColor: AppColor_Primary,
                      active: state_list[9],
                      onPressed: () {
                        setState(() {
                          clearStates();
                          state_list[9] = true;
                        });
                        widget.onSelectTime(time_list[9]);
                      },
                    ),
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TimeButton(
                    text: time_list[10],
                    backgroundColor: AppColor_Primary,
                    active: state_list[10],
                    onPressed: () {
                      setState(() {
                        clearStates();
                        state_list[10] = true;
                      });
                      widget.onSelectTime(time_list[10]);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TimeButton(
                    text: time_list[11],
                    backgroundColor: AppColor_Primary,
                    active: state_list[11],
                    onPressed: () {
                      setState(() {
                        clearStates();
                        state_list[11] = true;
                      });
                      widget.onSelectTime(time_list[11]);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(width: button_width),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(width: button_width),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
