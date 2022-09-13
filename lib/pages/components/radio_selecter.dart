import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/components/app_devider.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:decapet/pages/components/radio_item.dart';
import 'package:decapet/pages/components/underline_input.dart';

import 'h16.dart';
import 'radio_select_dlg.dart';

class RadioSelector extends StatefulWidget {
  RadioSelector(
      {Key? key,
      required this.selectedCategory,
      required this.categoryList,
      required this.onSelect,
      required this.hint})
      : super(key: key) {
  }

  String? selectedCategory = "";
  List<RadioItemData> categoryList;
  String hint;
  final void Function(int selectedIndex) onSelect;

  @override
  RadioSelectorState createState() => RadioSelectorState();
}

class RadioSelectorState extends State<RadioSelector> {

  String? selectedCategory = "";

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    for (int i = 0; i < widget.categoryList.length; i++) {
      widget.categoryList[i].item_selected =
          selectedCategory == widget.categoryList[i].item_name;
    }
  }

  void showRadioSelectorDialog() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return RadioSelectDialog(
            categoryList: widget.categoryList,
            onSelect: (selectedIndex) {
              setState(() {
                selectedCategory =
                    widget.categoryList[selectedIndex].item_name;
                for (int i = 0; i < widget.categoryList.length; i++) {
                  widget.categoryList[i].item_selected = false;
                }
                widget.categoryList[selectedIndex].item_selected = true;
                widget.onSelect(selectedIndex);
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      child: InkWell(
          onTap: () {
            showRadioSelectorDialog();
          },
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: selectedCategory == ""
                        ? H16(
                            text: widget.hint,
                            color: AppColor_Hint,
                            height: 1.5,
                            align: TextAlign.left,
                            weight: FW.medium)
                        : H16(text: selectedCategory!, align: TextAlign.left),
                  ),
                  Image.asset("assets/ic_blue_down.png", width: 15),
                ],
              ),
              const SizedBox(height: 7),
              Container(
                color: AppColor_Gray,
                height: 1,
                width: double.infinity,
              )
            ],
          )),
    );
  }
}
