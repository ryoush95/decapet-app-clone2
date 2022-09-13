import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h22.dart';
import 'package:decapet/pages/components/main_text_button.dart';

class TermsOfServiceDialog extends StatefulWidget {
  const TermsOfServiceDialog({Key? key}) : super(key: key);

  @override
  TermsOfServiceDialogState createState() => TermsOfServiceDialogState();
}

class TermsOfServiceDialogState extends State<TermsOfServiceDialog> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.pop(context);
    return true;
  }

  void onAgree() {}

  void onExit() {onBackPressed();}

  void onLeaveMessage() {
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return const WriteDialog();
    //     });
  }

  void onLeaveReview() {}

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return WillPopScope(
        onWillPop: onBackPressed,
        child: Container(
          height: 505,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                H22(
                  text: LanguageService.trans("termsofservice"),
                ),
                const SizedBox(width: 120),
                MainTextButton(
                  text: LanguageService.trans("close"),
                  backgroundColor: Colors.transparent,
                  style: AppTextStyle.PD(Colors.blue, 18, weight: FW.medium),
                  width: 58,
                  onPressed: () {
                    onExit();
                  },
                ),
              ]),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: H18(
                  text: LanguageService.trans("1th/alskdjf;as /as/dfa\nasdgsd\n"),
                  align: TextAlign.left,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MainTextButton(
                text: LanguageService.trans("agree"),
                backgroundColor: Colors.blue,
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.medium),
                //width: 350,
                height: 58,
                onPressed: () {
                  onAgree();
                },
              ),
            ),
            const SizedBox(height: 20),
          ]),
        ),
      );
    });
  }
}
