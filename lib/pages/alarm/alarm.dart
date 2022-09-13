import 'package:decapet/global/app_colors.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/alarm_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/items/alarm_item.dart';
import 'package:flutter/material.dart';

import 'alarm_detail.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  AlarmPageState createState() => AlarmPageState();
}

class AlarmPageState extends BaseState<AlarmPage> {
  List<AlarmDto> alarmList = [];
  ScrollController scrollController = ScrollController();
  bool isLast = false;
  int page = 0;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()..addListener(onScroll);

    // load alarm list
    loadAlarmList();
  }

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  void onScroll() {
    if (!isLoading) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadAlarmList();
      }
    }
  }

  void loadAlarmList() {
    showLoading();

    // TODO alarm loading
    try {
      api.alarm_list(user.info.access_token, page).then((value) {
        hideLoading();
        if (value.result == 0) {
          if (page == 0) {
            alarmList.clear();
          }
          setState(() {
            alarmList.addAll(value.data!.list);
            isLast = value.data!.isLast;
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
    await Future.delayed(const Duration(seconds: 0, milliseconds: 200));
    page = 0;
    loadAlarmList();
  }

  void onDetail(int index) {
    setState(() {
      user.info.alarm_cnt = user.info.alarm_cnt - 1;
    });
    Navigator.push(context, SlideRightTransRoute(builder: (context) => AlarmDetailPage(title: alarmList[index].title, time: alarmList[index].created_at, content: alarmList[index].description)));
    viewAlarm(index);
  }

  void viewAlarm(int index) {
    try {
      api.read_alarm(user.info.access_token, alarmList[index].id).then((value) {
        hideLoading();
        if (value.result == 0) {
          // alarmList.removeAt(index);
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans('Alarm'),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            //crossAxisAlignment: CrossAxisAlignment.start,
            child:
                // alarm list
                Container(
                    color: AppColor_GrayBackround,
                    child: RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: AlarmItem(item: alarmList[index]),
                              onTap: () {
                                onDetail(index);
                              },
                            );
                          },
                          itemCount: alarmList.length),
                    )),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
