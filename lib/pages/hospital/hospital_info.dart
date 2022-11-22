// import 'package:decapet/global/app_colors.dart';
// import 'package:decapet/global/app_styles.dart';
// import 'package:decapet/helpers/common_util.dart';
// import 'package:decapet/language/language_service.dart';
// import 'package:decapet/models/dto/hospital_dto.dart';
// import 'package:decapet/models/dto/hospital_equipment_item_dto.dart';
// import 'package:decapet/models/dto/hospital_service_item_dto.dart';
// import 'package:decapet/models/dto/review_dto.dart';
// import 'package:decapet/pages/base/base_state.dart';
// import 'package:decapet/pages/base/page_layout.dart';
// import 'package:decapet/pages/components/app_devider.dart';
// import 'package:decapet/pages/components/h12.dart';
// import 'package:decapet/pages/components/h14.dart';
// import 'package:decapet/pages/components/h16.dart';
// import 'package:decapet/pages/components/h18.dart';
// import 'package:decapet/pages/hospital/hospital_info_expeces_item.dart';
// import 'package:decapet/pages/items/hospital_info_bottom_item.dart';
// import 'package:decapet/pages/items/hospital_info_equipment_item.dart';
// import 'package:flutter/material.dart';
// // import 'package:naver_map_plugin/naver_map_plugin.dart';
// // import 'package:naver_map_plugin/naver_map_plugin.dart';
//
// class HospitalInfo extends StatefulWidget {
//   final HospitalDto item;
//
//   const HospitalInfo({
//     Key? key,
//     required this.item,
//   }) : super(key: key);
//   @override
//   HospitalInfoState createState() => HospitalInfoState();
// }
//
// class HospitalInfoState extends BaseState<HospitalInfo> with TickerProviderStateMixin {
//   int tabIndex = 0;
//
//   List<HospitalServiceItemDto> services = [];
//   List<HospitalEquipmentItemDto> equipments = [];
//   List<ReviewDto> reviewList = [];
//
//   //bool IsexistImage = true;
//   late TabController tabController;
//   int curCategory = 0;
//   List<HospitalInfoExpenseItem> expense_items = [];
//   List<HospitalInfoEquipmentItem> equipment_items = [];
//   var parkinfoController = TextEditingController();
//   var scrollController = ScrollController();
//
//   // TODO YJ
//   MapCreateCallback? mapCreateCallback;
//   late CameraPosition initialCameraPosition;
//   List<Marker> markers = [];
//   @override
//   void initState() {
//     super.initState();
//     // TODO YJ
//     initialCameraPosition = CameraPosition(target: LatLng(widget.item.latitude, widget.item.longitude));
//
//     tabController = TabController(length: 2, vsync: this);
//     tabController.addListener(() {
//       changeTab(tabController.index);
//     });
//
//     loadHospitalServices();
//     loadHospitalEquipments();
//     loadReviewList();
//   }
//
//   Future<void> initData() async {
//     // TODO YJ
//     // markers.add(Marker(
//     //     markerId: "0",
//     //     position: LatLng(widget.item.latitude, widget.item.longitude),
//     //     icon: await OverlayImage.fromAssetImage(assetName: "assets/ic_my_loc.png"),
//     //     onMarkerTab: (marker, iconSize) {
//     //       showToast(marker!.markerId);
//     //     }));
//
//     setState(() {});
//   }
//
//   Future<bool> onBackPressed() async {
//     if (keyboardIsVisible(context)) {
//       FocusScope.of(context).requestFocus(FocusNode());
//     }
//     Navigator.of(context).pop();
//     return true;
//   }
//
//   void changeTab(int tab) {
//     setState(() {
//       tabIndex = tab;
//       tabController.index = tabIndex;
//     });
//   }
//
//   void onChooseCategory(int index) {
//     setState(() {
//       curCategory = index;
//     });
//   }
//
//   void loadHospitalServices() {
//     // showLoading();
//     try {
//       api.hospital_services(user.info.access_token, widget.item.id).then((value) {
//         hideLoading();
//         if (value.result == 0) {
//           setState(() {
//             services.addAll(value.data!.list);
//           });
//         } else {
//           showToast(value.msg!);
//         }
//       });
//     } on Exception catch (_, e) {
//       hideLoading();
//       showToast(LanguageService.trans("network_error"));
//     }
//   }
//
//   void loadHospitalEquipments() {
//     // showLoading();
//     try {
//       api.hospital_equipments(user.info.access_token, widget.item.id).then((value) {
//         hideLoading();
//         if (value.result == 0) {
//           setState(() {
//             equipments.addAll(value.data!.list);
//           });
//         } else {
//           showToast(value.msg!);
//         }
//       });
//     } on Exception catch (_, e) {
//       hideLoading();
//       showToast(LanguageService.trans("network_error"));
//     }
//   }
//
//   void loadReviewList() {
//     showLoading();
//     try {
//       api.review_list(user.info.access_token, 0, widget.item.id, "", "", "recent", 0).then((res) {
//         if (res.result == 0) {
//           hideLoading();
//           reviewList.clear();
//           setState(() {
//             reviewList.addAll(res.data!.list);
//           });
//         } else {
//           hideLoading();
//           showToast(res.msg!);
//         }
//       });
//     } on Exception catch (_, e) {
//       hideLoading();
//       showToast(LanguageService.trans("network_error"));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PageLayout(
//         isLoading: isLoading,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: H16(
//                             text: widget.item.name,
//                           ),
//                         ),
//                         Container(
//                             width: 64,
//                             height: 26,
//                             margin: const EdgeInsets.only(left: 20),
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: widget.item.vaccination_yn == 'y' ? AppColor_Light_Blue : AppColor_Primary_Disable),
//                             child: Center(
//                               child: H12(
//                                 text: LanguageService.trans("Vaccination"),
//                                 weight: FW.semi_bold,
//                                 color: widget.item.vaccination_yn == 'y' ? Colors.blue : Colors.grey,
//                               ),
//                             )),
//                         const SizedBox(width: 5),
//                         Container(
//                             width: 64,
//                             height: 26,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: widget.item.treating_yn == 'y' ? AppColor_Light_Blue : AppColor_Primary_Disable),
//                             child: Center(
//                               child: H12(
//                                 text: LanguageService.trans("Treating"),
//                                 weight: FW.semi_bold,
//                                 color: widget.item.treating_yn == 'y' ? Colors.blue : Colors.grey,
//                               ),
//                             )),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     H14(
//                       text: widget.item.address,
//                       weight: FW.medium,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         Image.asset(
//                           "assets/ic_like_on.png",
//                           width: 15,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         H14(
//                           text: widget.item.like_cnt.toString(),
//                           weight: FW.bold,
//                           color: Colors.blue,
//                         ),
//                         const SizedBox(
//                           width: 40,
//                         ),
//                         Image.asset(
//                           "assets/ic_tel.png",
//                           width: 15,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         H14(
//                           text: widget.item.phone_number,
//                           weight: FW.bold,
//                           color: Colors.blue,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//                       decoration: BoxDecoration(color: AppColor_Light_Gray, borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           H16(
//                             text: LanguageService.trans("estimated_medical_expenses"),
//                             weight: FW.bold,
//                           ),
//                           const SizedBox(height: 10),
//                           ListView.builder(
//                               scrollDirection: Axis.vertical,
//                               shrinkWrap: true,
//                               controller: scrollController,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return HospitalInfoExpenseItem(name: services[index].name, value: services[index].price);
//                               },
//                               itemCount: services.length),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     AppDivider(
//                       height: 8.0,
//                       color: Color(0xFFF8F9FA),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//                       decoration: BoxDecoration(color: AppColor_White, borderRadius: BorderRadius.circular(10)),
//                       child: SingleChildScrollView(
//                           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                         H16(
//                           text: LanguageService.trans("main_equipment"),
//                           align: TextAlign.left,
//                           weight: FW.bold,
//                         ),
//                         ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             controller: scrollController,
//                             itemBuilder: (BuildContext context, int index) {
//                               return HospitalInfoEquipmentItem(title: equipments[index].name, text: equipments[index].description);
//                             },
//                             itemCount: equipments.length),
//                       ])),
//                     ),
//                     AppDivider(
//                       height: 8.0,
//                       color: Color(0xFFF8F9FA),
//                     ),
//                     Container(
//                         // height: 360,
//                         padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//                         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                           H16(
//                             text: LanguageService.trans("hospital_location"),
//                             align: TextAlign.left,
//                             weight: FW.bold,
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Image.asset(
//                                 "assets/ic_location.png",
//                                 width: 14,
//                                 color: Colors.blue,
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               H14(
//                                 text: widget.item.address,
//                                 weight: FW.bold,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 35,
//                               ),
//                               H14(
//                                 text: widget.item.distance,
//                                 weight: FW.regular,
//                                 color: AppColor_36383C.withOpacity(0.4),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Container(
//                             height: 266,
//                             width: double.infinity,
//                             // TODO YJ
//                             child: NaverMap(
//                               onMapCreated: (value) {
//                                 initData();
//                               },
//                               initialCameraPosition: initialCameraPosition,
//                               rotationGestureEnable: false,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                           H14(
//                             text: LanguageService.trans("park_info"),
//                           ),
//                           H14(
//                             text: widget.item.park_info,
//                             weight: FW.medium,
//                             height: 1.5,
//                             maxLine: 2,
//                             color: AppColor_GrayText,
//                           ),
//                           // TextField(
//                           //   style: AppTextStyle.PD(Colors.black, 14,
//                           //       weight: FW.regular),
//                           //   maxLength: 100,
//                           //   controller: parkinfoController,
//                           //   onEditingComplete: () {
//                           //     FocusScope.of(context)
//                           //         .requestFocus(FocusNode());
//                           //   },
//                           //   textInputAction: TextInputAction.done,
//                           //   maxLines: 1,
//                           //   decoration: InputDecoration(
//                           //     counterText: widget.item.caution,
//                           //     hintText: LanguageService.trans(
//                           //         "Park Info Input"),
//                           //     hintStyle: AppTextStyle.PD(
//                           //         AppColor_Gray, 14,
//                           //         weight: FW.medium),
//                           //     border: InputBorder.none,
//                           //   ),
//                           //   onChanged: (text) {
//                           //     //onChange(text);
//                           //   },
//                           // ),
//                         ])),
//                     AppDivider(
//                       height: 8.0,
//                       color: Color(0xFFF8F9FA),
//                     ),
//                     SizedBox(height: 40),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 0),
//                       child: H18(
//                         text: LanguageService.trans("recent_review"),
//                         align: TextAlign.left,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Container(
//                       width: double.infinity,
//                       height: reviewList.isNotEmpty ? 350 : 20,
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           shrinkWrap: true,
//                           itemBuilder: (BuildContext context, int index) {
//                             return HospitalInfoBottomItem(item: reviewList[index]);
//                           },
//                           itemCount: reviewList.length),
//                     ),
//                     AppDivider(
//                       height: 8.0,
//                       color: Color(0xFFF8F9FA),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           H16(
//                             text: LanguageService.trans("caution"),
//                             weight: FW.bold,
//                             align: TextAlign.left,
//                           ),
//                           SizedBox(
//                             height: 12,
//                           ),
//                           H14(
//                             text: widget.item.caution,
//                             weight: FW.medium,
//                             height: 1.5,
//                             maxLine: 2,
//                             color: AppColor_GrayText,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     AppDivider(
//                       height: 8.0,
//                       color: Color(0xFFF8F9FA),
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           H16(
//                             text: LanguageService.trans("decafe_alarm"),
//                             weight: FW.bold,
//                             align: TextAlign.left,
//                           ),
//                           SizedBox(
//                             height: 12,
//                           ),
//                           // Text(
//                           //   LanguageService.trans("hospital_info_bottom_description"),
//                           //   style: AppTextStyle.PD(AppColor_GrayText, 14, height: 1.5),
//                           //   maxLines: null,
//                           // ),
//                           RichText(
//                             text: TextSpan(
//                               style: const TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.black,
//                               ),
//                               children: <TextSpan>[
//                                 TextSpan(text: '병원 정보의 수정이 필요한 경우, 병원 사업자등록증, 원장의 수의사면허증 사본을 첨부하여 변경사항을 ', style: TextStyle(color: Color(0xFF36383C).withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w500)),
//                                 TextSpan(text: 'decapet@gmail.com', style: new TextStyle(color: Color(0xFF1A8DF0), fontSize: 14, fontWeight: FontWeight.bold)),
//                                 TextSpan(text: '으로 송부하여 주시면 1달 이내로 검토하여 반영해 드립니다.', style: new TextStyle(color: Color(0xFF36383C).withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w500, height: 1.5)),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 50),
//             ],
//           ),
//         ));
//   }
// }
