import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/blood_test_result_item_dto.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/material.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/components/h12.dart';

class BloodTestResultItem extends StatefulWidget {
  BloodTestResultItemDto item;

  BloodTestResultItem({required this.item});

  @override
  BloodTestResultItemState createState() => BloodTestResultItemState();
}

class BloodTestResultItemState extends BaseState<BloodTestResultItem> {

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {

  }


  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < widget.item.row_count; i++) {
      List<Widget> columns = [];
      for (int j = 0; j < widget.item.datas[i].length; j++) {
        columns.add(Flexible(
            fit: FlexFit.tight,
            flex: 1,
              child: Center(
                child: H14(
                  align: TextAlign.center,
                  text: widget.item.datas[i][j],
                  weight: FW.medium,
              )
              ),
            ));

        columns.add((SizedBox(height: 30)));
      }
      rows.add(Row(
        children: columns,
      ));
    }
    List<Widget> headers = [];
    for (String h in widget.item.headers) {
      headers.add(
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: H14(
            text: h,
            align: TextAlign.center,
            weight: FW.bold,
          ),
        ),
      );
    }
    return Container(
        width:300,
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Row(
                children:[
                  SizedBox(width: 20,),
                  H16(
                    text: LanguageService.trans(widget.item.title),
                    align: TextAlign.left,
                    weight: FW.bold,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(children: headers),
              SizedBox(height: 15),
              AppDivider(height: 2.0,),
              SizedBox(height: 10),
              Column(
                children: rows,
              )
            ]
        )
    );
  }
}

