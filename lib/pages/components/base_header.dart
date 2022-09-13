import 'package:flutter/material.dart';
import 'package:decapet/global/app_styles.dart';
import 'h18.dart';

class BaseHeader extends StatelessWidget {
  final title;
  final onBackPressed;

  BaseHeader({Key? key,
    this.title,
    this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: [
          Center(
            child: H18(text: title, weight: FW.medium),
          ),
        ],
      ),
    );
  }
}
