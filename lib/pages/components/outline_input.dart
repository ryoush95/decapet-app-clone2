import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/base/page_layout.dart';

class OutlineInput extends StatelessWidget {
  final controller;
  final keyboardType;
  final textInputAction;
  final onEditingComplete;
  final placeholder;
  final onChanged;
  final borderColor;
  double? borderRadius;
  final hintColor;
  bool? isSecure;
  int? maxLine;
  int? maxLength;
  double? height;
  final weight;
  final size;
  final textAlign;
  String? imagePath;

  OutlineInput(
      {Key? key,
      this.controller,
      this.keyboardType,
      this.placeholder,
      this.textInputAction,
      this.onEditingComplete,
      this.onChanged,
      this.borderColor,
      this.borderRadius,
      this.hintColor,
      this.maxLine,
      this.maxLength,
      this.height,
      this.weight,
      this.size,
      this.imagePath,
      this.textAlign,
      this.isSecure})
      : super(key: key) {
    isSecure ??= false;
    maxLine ??= 1;
    height ??= 50;
    borderRadius ??= 4.0;
    maxLength ??= -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextField(
        style: AppTextStyle.PD(AppColor_BlackText, size ?? 16,
            weight: weight ?? FW.medium),
        maxLength: maxLength,
        controller: controller,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        obscureText: isSecure!,
        textAlignVertical: TextAlignVertical.bottom,
        textAlign: textAlign ?? TextAlign.left,
        textInputAction: textInputAction,
        maxLines: maxLine,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor_Selector_Border),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius!))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor_Primary),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius!))
          ),
          hintText: placeholder,
          hintStyle: AppTextStyle.PD(
            hintColor ?? AppColor_Hint,
            16,
            weight: FW.medium,
          ),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
