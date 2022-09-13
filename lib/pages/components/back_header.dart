import 'package:flutter/material.dart';
import 'package:decapet/global/app_styles.dart';
import 'h18.dart';

class BackHeader extends StatelessWidget {
  final title;
  final onBackPressed;

  BackHeader({Key? key,
    this.title,
    this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding:
       const EdgeInsets.only(top: 20),
      // height: 60,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                child: Image.asset('assets/btn_back.png', width: 10)
                // onTap: onBackPressed
              )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: H18(text: title, weight: FW.medium, height: 1.1),
          ),
        ],
      ),
    );
  }
}
