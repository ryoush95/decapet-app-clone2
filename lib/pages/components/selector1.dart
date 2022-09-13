import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'h16.dart';

class Selector1 extends StatelessWidget {
  Selector1({Key? key, required this.selectedCategory, required this.categoryList, required this.onSelect, required this.hint}) : super(key: key) {
    this.selectedCategory ??= "";
  }

  String? selectedCategory;
  List<String> categoryList;
  String hint;
  final void Function(int index) onSelect;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      itemHeight: 50,
      icon: Image.asset('assets/ic_blue_down.png', width: 12),
      hint: H16(text: selectedCategory!.isEmpty ? hint : selectedCategory!, weight: FW.medium, color: selectedCategory!.isEmpty ? AppColor_Hint : AppColor_BlackText),
      items: categoryList
          .map((label) => DropdownMenuItem(
                child: Text(label.toString()),
                value: label,
              ))
          .toList(),
      isExpanded: false,
      onChanged: (value) {
        onSelect(categoryList.indexOf(value!));
      },
      style: AppTextStyle.PD(
        AppColor_BlackText,
        16,
        weight: FW.medium,
      ),
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor_Selector_Border),
            // borderRadius: BorderRadius.all(Radius.circular(12.0)
          )),
    );
  }
}
