import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sprintf/sprintf.dart';

import 'h14.dart';
import 'h16.dart';
import 'h20.dart';

class AppCalendar extends StatefulWidget {
  DateTime? current;

  AppCalendar({Key? key, this.current, required this.onDateSelected}) : super(key: key);

  final void Function(DateTime datetime) onDateSelected;

  @override
  AppCalendarState createState() => AppCalendarState();
}

class CItem {
  int day;
  int weekday;
  int year;
  int month;

  CItem(this.day, this.weekday, this.year, this.month) {}
}

class AppCalendarState extends State<AppCalendar> {
  DateTime? current;
  int? year;
  int? month;
  List<List<CItem>> days = [];
  List<CItem> list = [];

  bool isFirstStatus = true;

  @override
  void initState() {
    super.initState();
    current = widget.current ?? DateTime.now();
    changeYM(current!.year, current!.month);
  }

  void changeCurrent(CItem item) {
    setState(() {
      isFirstStatus = false;
      current = DateTime(item.year, item.month, item.day);
      widget.current = current;
      widget.onDateSelected(current!);
    });
  }

  void changeYM(int year, int month) {
    setState(() {
      this.year = year;
      this.month = month;
      days.clear();
      DateTime dt = DateTime(year, month, 1);
      this.year = dt.year;
      this.month = dt.month;
      int wd = dt.weekday;
      if (wd == 7) wd = 0;
      list.clear();
      for (int i = 0; i < wd; i++) {
        DateTime dt2 = DateTime(year, month, 1 - wd + i);
        list.add(CItem(dt2.day, dt2.weekday, dt2.year, dt2.month));
      }
      while (true) {
        list.add(CItem(dt.day, dt.weekday, dt.year, dt.month));
        DateTime dt2 = DateTime(year, month, dt.day + 1);
        if (dt2.month != dt.month) break;
        dt = dt2;
      }
      int len = list.length;
      for (int i = len; i < 42; i++) {
        DateTime dt2 = DateTime(year, month, 1 - wd + i);
        list.add(CItem(dt2.day, dt2.weekday, dt2.year, dt2.month));
      }
      for (int i = 0; i < 6; i++) {
        List<CItem> ls = [];
        for (int j = 0; j < 7; j++) {
          ls.add(list[i * 7 + j]);
        }
        days.add(ls);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < days.length; i++) {
      List<Widget> columns = [];
      List<CItem> cols = days[i];
      for (int j = 0; j < cols.length; j++) {
        CItem item = cols[j];
        bool isCurrent = item.day == current!.day && item.year == current!.year && item.month == current!.month;

        DateTime currDate = DateTime.parse(item.year.toString() + "-" + (item.month > 9 ? item.month.toString() : "0" + item.month.toString()) + "-" + (item.day > 9 ? item.day.toString() : "0" + item.day.toString()));

        bool isBefore = DateTime.now().difference(currDate).inDays > 0;
        columns.add(Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: InkWell(
              onTap: () {
                // TODO YJ
                // if(isBefore) {
                //   return;
                // }
                changeCurrent(item);
              },
              child: Center(
                child: Container(
                    width: 32,
                    height: 32,
                    //constraints: const BoxConstraints(maxWidth: 30, maxHeight: 30),
                    decoration: isCurrent && widget.current != null
                        ? BoxDecoration(
                            color: AppColor_Primary,
                            borderRadius: BorderRadius.circular(15),
                          )
                        : null,
                    child: Center(
                        child: H16(
                      align: TextAlign.center,
                      text: sprintf("%d", [item.day]),
                      weight: FW.medium,
                      // color: isBefore
                      //     ? Color(0xFFD7D7D8)
                      //     : (isCurrent && widget.current != null
                      //         ? AppColor_White
                      //         : (j == 0
                      //             ? AppColor_Red
                      //             : j == 6
                      //                 ? AppColor_Primary
                      //                 : Colors.black)),
                      color: (isCurrent && widget.current != null
                          ? AppColor_White
                          : (j == 0
                              ? AppColor_Red
                              : j == 6
                                  ? AppColor_Primary
                                  : Colors.black)),
                    ))),
              ),
            )));
        columns.add(SizedBox(height: 40));
      }
      rows.add(Row(
        children: columns,
      ));
    }
    List<Widget> headers = [];
    List<String> hs = ["S", "M", "T", "W", "T", "F", "S"];
    for (String h in hs) {
      headers.add(
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: H14(
            text: h,
            align: TextAlign.center,
            weight: FW.semi_bold,
          ),
        ),
      );
    }
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset('assets/ic_left.png', width: 10),
            ),
            onTap: () {
              changeYM(year!, month! - 1);
            }),
        const SizedBox(width: 15),
        H20(text: sprintf("%d.%02d", [year, month])),
        const SizedBox(width: 15),
        InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset('assets/ic_right.png', width: 10),
            ),
            onTap: () {
              changeYM(year!, month! + 1);
            })
      ]),
      SizedBox(height: 15),
      Row(children: headers),
      SizedBox(height: 10),
      Column(
        children: rows,
      )
    ]));
  }
}
