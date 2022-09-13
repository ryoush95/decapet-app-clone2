import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final controller;
  final onEditingComplete;
  final placeholder;
  final void Function(String keyword) onChanged;

  SearchInput({Key? key, this.controller, this.placeholder, this.onEditingComplete, required this.onChanged}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white, border: Border.all(color: AppColor_Gray)),
      child: TextField(
        controller: controller,
        onEditingComplete: onEditingComplete,
        keyboardType: TextInputType.text,
        obscureText: false,
        textInputAction: TextInputAction.search,
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 14.0),
            suffixIcon: IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              icon: Image.asset(
                "assets/search_black_24dp.png",
                height: 30,
              ),
              onPressed: onEditingComplete,
            ),
            hintText: placeholder,
            hintStyle: AppTextStyle.PD(
              AppColor_Hint,
              16,
              weight: FW.medium,
            ),
            border: InputBorder.none,
            counterText: ""),
        onChanged: (text) {
          onChanged(text);
        },
      ),
    );
  }
}
