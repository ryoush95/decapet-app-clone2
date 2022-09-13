import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/base/page_layout.dart';

class UnderlineInput extends StatelessWidget {
  final controller;
  final keyboardType;
  final textInputAction;
  final onEditingComplete;
  final placeholder;
  final onChanged;
  final borderColor;
  final hintColor;
  bool? isSecure;
  int? maxLine;
  int? maxLength;
  double? height;
  final weight;
  final size;
  final textAlign;
  final onTap;
  bool? readOnly;

  UnderlineInput(
      {Key? key,
        this.controller,
        this.keyboardType,
        this.placeholder,
        this.textInputAction,
        this.onEditingComplete,
        this.onChanged,
        this.borderColor,
        this.hintColor,
        this.maxLine,
        this.maxLength,
        this.height,
        this.weight,
        this.size,
        this.textAlign,
        this.isSecure,
        this.onTap,
        this.readOnly,
      })
      : super(key: key) {
    isSecure ??= false;
    maxLine ??= 1;
    height ??= 40;
    maxLength ??= -1;
    readOnly ??= false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Center(
        child: TextField(
          readOnly: readOnly?? false,
          style: AppTextStyle.PD(AppColor_BlackText, size ?? 16, weight: weight ?? FW.medium),
          maxLength: maxLength,
          controller: controller,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          obscureText: isSecure!,
          textAlignVertical: TextAlignVertical.center,
          textAlign: textAlign ?? TextAlign.start,
          textInputAction: textInputAction,
          maxLines: maxLine,
          decoration: InputDecoration(
            counterText: "",
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor_Selector_Border),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: readOnly! ? AppColor_Selector_Border: AppColor_Primary),
            ),
            hintText: placeholder,
            hintStyle: AppTextStyle.PD(hintColor ?? AppColor_Hint, 16, weight: FW.medium),
            border: InputBorder.none,
          ),
          onChanged: onChanged,
          onTap: onTap,
        ),
      ),
    );
  }
}
