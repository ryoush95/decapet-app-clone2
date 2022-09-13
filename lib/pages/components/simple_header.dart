import 'package:flutter/material.dart';
import 'package:decapet/global/app_styles.dart';
import 'h18.dart';

class SimpleHeader extends StatelessWidget {
  final title;
  final maxline;
  final onBackPressed;

  SimpleHeader({Key? key,
    this.title,
    this.maxline,
    this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset('assets/btn_back.png', width: 10)
                ),
                onTap: onBackPressed,
              )
          ),
          Center(
            child: H18(text: title, weight: FW.medium, maxLine: maxline,),
          ),
        ],
      ),
    );
  }
}
