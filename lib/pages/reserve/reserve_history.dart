import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/reservation_dto.dart';
import 'package:decapet/models/dto/schedules_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/bloodtest/bloodtest_selopt.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/items/reservation_item.dart';
import 'package:decapet/pages/reserve/reserve_detail.dart';
import 'package:flutter/material.dart';

class ReserveHistoryPage extends StatefulWidget {
  @override
  ReserveHistoryPageState createState() => ReserveHistoryPageState();
}

class ReserveHistoryPageState extends BaseState<ReserveHistoryPage> with TickerProviderStateMixin {
  List<ReservationDto> reservationList = [];
  ScrollController scrollController = ScrollController();

  bool isLast = false;
  int page = 0;

  // int currentTotalCount = 0;
  int pastTotalCount = 0;
  int count = 0;

  String datePassStatus = "false";
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          changeTab("false");
        } else {
          changeTab("true");
        }
      }
    });
    scrollController = ScrollController()..addListener(loadMore);
    loadReservationList();
  }

  void loadReservationList() {
    showLoading();
    try {
      api.reservation_history(user.info.access_token, datePassStatus == "false" ? "0" : "1", page).then((value) {
        hideLoading();
        if (value.result == 0) {
          if (page == 0) {
            reservationList.clear();
          }

          setState(() {
            if (datePassStatus == "false") {
              //currentTotalCount = value.data!.totalCount;
            } else {
              pastTotalCount = value.data!.totalCount;
            }
            reservationList.addAll(value.data!.list);
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
    loadReservationList();
  }

  void loadMore() {
    if (!isLoading) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadReservationList();
      }
    }
  }

  void changeTab(status) {
    setState(() {
      datePassStatus = status;
    });
    page = 0;
    loadReservationList();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return true;
  }

  void onCheckReservation(int reservationId, int index) {
    int hositalid = 0;
    for (int i = 0; i < reservationList.length; i++) {
      if (reservationId == reservationList.elementAt(i).id) {
        hositalid = reservationList.elementAt(i).id;
        break;
      }
    }
    showLoading();
    try {
      api.hosiptalSchInfo(user.info.access_token, hositalid).then((value) async {
        hideLoading();
        if (value.result == 0) {
          List<SchedulesDto> schList = value.data!.list;
          List<SchedulesDto> specialList = value.data!.special;
          String recv = await Navigator.push(
              context,
              SlideRightTransRoute(
                builder: (context) => ReserveDetailPage(
                  reservationId: reservationId,
                  datePassStatus: datePassStatus,
                  list: schList,
                ),
              ));
          if (recv == "200") {
            reservationList.removeAt(index);
            setState(() {});
            getAppInfo();
          }
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
    int hositalid = 0;
    for (int i = 0; i < reservationList.length; i++) {
      if (reservationId == reservationList.elementAt(i).id) {
        hositalid = reservationList.elementAt(i).id;
        break;
      }
    }
    showLoading();
    try {
      api.hosiptalSchInfo(user.info.access_token, hositalid).then((value) {
        hideLoading();
        if (value.result == 0) {
          List<SchedulesDto> schList = value.data!.list;
          List<SchedulesDto> specialList = value.data!.special;
          Navigator.push(
            context,
            SlideRightTransRoute(
              builder: (context) => BloodTestAppSetOptPage(
                reserveId: reservationId,
                list: schList,
                specialList: specialList,
              ),
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

  void onCancelReservation(index) {
    onReserveCancel(reservationList[index].id, index);
  }

  void onCancelReservation1(int _id, int _index) {
    showLoading();
    try {
      api.cancelReservation(user.info.access_token, _id).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            reservationList.removeAt(_index);
            setState(() {});
            getAppInfo();
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

  void getAppInfo() {
    showLoading();
    try {
      api.appInfo(user.info.access_token).then((res) {
        if (res.result == 0) {
          hideLoading();
          setState(() {
            user.info.reservation_cnt = res.data!.reserve_cnt;
            user.info.reserve_past_cnt = res.data!.reserve_past_cnt;
            user.setInfo(user.info);
            event.fire(ReserveCancelled());
            setState(() {});
          });
        } else {
          hideLoading();
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void onReserveCancel(int _id, int _index) {
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
                  onCancelReservation1(_id, _index);
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
      onBack: onBackPressed,
      isLoading: isLoading,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleHeader(
              title: LanguageService.trans('reservation_history'),
              onBackPressed: onBackPressed,
            ),
            Container(height: 20, color: Colors.white),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Row(
                  children: [
                    H24B(
                      text: user.info.name + "님은",
                    ),
                    H24B(
                      text: " " + (user.info.reservation_cnt + user.info.reserve_past_cnt).toString(),
                      color: Color(0xFF1A8DF0),
                    ),
                    H24B(
                      text: "회 예약하셨습니다.",
                    ),
                  ],
                )),
            Container(height: 30, color: Colors.white),
            // Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 25),
            //     color: Colors.white,
            //     height: 40,
            //     child: Align(
            //       alignment: Alignment.centerLeft,
            //       child: TabBar(
            //         tabs: [
            //           Tab(
            //             child: H14(
            //               text: currentTotalCount.toString() + " " + LanguageService.trans("bookings"),
            //               color: datePassStatus == "false" ? Colors.black : AppColor_Tab_Unselected,
            //             ),
            //           ),
            //           Tab(
            //             child: H14(
            //               text: LanguageService.trans("past reservation"),
            //               color: datePassStatus == "false" ? AppColor_Tab_Unselected : Colors.black,
            //             ),
            //           ),
            //         ],
            //         isScrollable: true,
            //         controller: _tabController,
            //         padding: EdgeInsets.zero,
            //         indicatorWeight: 5,
            //         unselectedLabelColor: AppColor_Tab_Unselected,
            //         indicatorColor: Color(0xFF1A8DF0).withOpacity(0.2),
            //         labelColor: Colors.black,
            //       ),
            //     )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              color: Colors.white,
              height: 20,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      reservationList.clear();
                      setState(() {});
                      changeTab("false");
                    },
                    child: SizedBox(
                      width: 85,
                      child: Stack(
                        children: [
                          H16(
                            text: user.info.reservation_cnt.toString() + " " + LanguageService.trans("bookings"),
                            color: datePassStatus == "false" ? AppColor_36383C : AppColor_36383C.withOpacity(0.3),
                            weight: FW.semi_bold,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 85,
                              height: datePassStatus == "false" ? 6 : 0,
                              color: AppColor_1A8DF0.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      reservationList.clear();
                      setState(() {});
                      changeTab("true");
                    },
                    child: Container(
                      width: 60,
                      child: Stack(
                        children: [
                          H16(
                            text: LanguageService.trans("past reservation"),
                            color: datePassStatus == "false" ? AppColor_36383C.withOpacity(0.3) : AppColor_36383C,
                            weight: FW.semi_bold,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 60,
                              height: datePassStatus == "false" ? 0 : 6,
                              color: AppColor_1A8DF0.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Container(
              height: 12,
              color: AppColor_Divider,
            ),
            Visibility(
                visible: datePassStatus == "false" ? user.info.reservation_cnt == 0 : pastTotalCount == 0,
                child: Expanded(
                  child: Container(
                    height: double.infinity,
                    color: AppColor_Divider,
                    child: Center(
                      child: H16(
                        color: AppColor_GrayText,
                        align: TextAlign.justify,
                        text: datePassStatus == "false" ? LanguageService.trans('No reservations right now:)') : LanguageService.trans('There is no reservation record:)'),
                      ),
                    ),
                  ),
                )),
            Expanded(
              child: Container(
                color: AppColor_Divider,
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return ReservationItem(
                          reservation: reservationList[index],
                          datePassStatus: datePassStatus,
                          onCheckReservation: (reservationId) {
                            onCheckReservation(reservationId, index);
                          },
                          onCancelReservation: (reservationId) {
                            onCancelReservation(index);
                          },
                          onChangeReservation: (reservationId) {
                            onChangeReservation(reservationId);
                          },
                        );
                      },
                      itemCount: reservationList.length),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
