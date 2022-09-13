import 'package:decapet/global/global.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/global/app_styles.dart';

class SymptomDto {
  String content;
  int uid;

  SymptomDto({
    required this.uid,
    required this.content,
  });
}

class SymptomItem extends StatefulWidget {
  String item;
  bool checked = false;
  final void Function(bool checked, String name) onChecked;

  SymptomItem({required this.item, required this.onChecked});

  @override
  SymptomItemState createState() => SymptomItemState();
}

class SymptomItemState extends BaseState<SymptomItem> {
  String userName = "test";
  bool showDetail = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {}

  void toggleDetail() {
    if (isSick == "n") return;
    setState(() {
      showDetail = !showDetail;
    });
    widget.onChecked(showDetail, widget.item);
  }

  void onValid() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleDetail,
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: 350,
            decoration: BoxDecoration(
              color: showDetail ? AppColor_Light_Blue : AppColor_GrayBackround,
              border: showDetail
                  ? Border.all(color: Colors.lightBlue, width: 1.0)
                  : Border.all(color: AppColor_White, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: H14(
                text: widget.item,
                color: showDetail ? Colors.blue : AppColor_GrayText,
                align: TextAlign.center,
                weight: FW.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
