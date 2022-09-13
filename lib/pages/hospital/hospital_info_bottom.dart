import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/items/hospital_info_bottom_item.dart';
import 'package:flutter/cupertino.dart';

class HospitalInfoBottomPage extends StatelessWidget {
  final hospitalId;

  HospitalInfoBottomPage({Key? key, this.hospitalId}) : super(key: key);

  List<HospitalInfoBottomItemData> items = [];

  void loadHospitalInfoBottom() {
    items.add(HospitalInfoBottomItemData(
      title: LanguageService.trans('diagnosis'),
      image: 'assets/bg_shadow.png',
      text: LanguageService.trans("hospital_info_bottom_description"),
      btn_text: LanguageService.trans("more"),
    ));
    items.add(HospitalInfoBottomItemData(
      title: LanguageService.trans('diagnosis'),
      image: 'assets/bg_shadow.png',
      text: LanguageService.trans("hospital_info_bottom_description"),
      btn_text: LanguageService.trans("more"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadHospitalInfoBottom();
    return Container(
      // width: 340,
      // margin: const EdgeInsets.only(right: 15),
      // padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     H18(
      //       text: LanguageService.trans("recent_review"),
      //       align: TextAlign.left,
      //     ),
      //     Container(
      //       width: double.infinity,
      //       height: 300,
      //       child: ListView.builder(
      //           scrollDirection: Axis.horizontal,
      //           shrinkWrap: true,
      //           itemBuilder: (BuildContext context, int index) {
      //             return HospitalInfoBottomItem(item: items[index]);
      //           },
      //           itemCount: items.length),
      //     ),
      //   ],
      // ),
    );
  }
}
