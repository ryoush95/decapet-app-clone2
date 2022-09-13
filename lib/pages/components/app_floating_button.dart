import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/base/page_layout.dart';

class AppFloatingButton extends StatelessWidget {
  final onPressed;

  AppFloatingButton({
    Key? key,
    this.onPressed,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height: 85,
      child: FloatingActionButton(
        highlightElevation: 0,
        focusElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Image.asset("assets/add_circle_black_24dp.png"),
      ),
    );
  }
}
