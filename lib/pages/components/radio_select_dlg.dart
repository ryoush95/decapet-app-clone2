import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'h16.dart';
import 'radio_item.dart';

class RadioSelectDialog extends StatefulWidget {
  RadioSelectDialog({
    Key? key,
    required this.categoryList,
    required this.onSelect,
  }) : super(key: key);

  List<RadioItemData> categoryList;
  final void Function(int selectedIndex) onSelect;

  @override
  RadioSelectDialogState createState() => RadioSelectDialogState();
}

class RadioSelectDialogState extends State<RadioSelectDialog> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.pop(context);
    return true;
  }

  void onSave(int index) {
    Navigator.pop(context);
    widget.onSelect(index);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return WillPopScope(
          child: Container(
            height: 315,
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Colors.white),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  RadioItemData item = widget.categoryList[index];
                  return InkWell(
                      onTap: () {
                        onSave(index);
                      },
                      child: Column(
                        children: [
                          SizedBox(height:10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: H16(
                                  text: item.item_name,
                                  align: TextAlign.left,
                                  weight: FW.medium,
                                  color: AppColor_BlackText,
                                  height: 1.8,
                                ),
                              ),
                              Image.asset(
                                item.item_selected
                                    ? 'assets/ic_radio_on.png'
                                    : 'assets/ic_radio_off.png',
                                width: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ));
                },
                itemCount: widget.categoryList.length),
          ),
          onWillPop: onBackPressed);
    });
  }
}
