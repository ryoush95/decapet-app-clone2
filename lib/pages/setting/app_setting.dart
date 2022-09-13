import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/components/simple_header.dart';

class AppSettingPage extends StatefulWidget {
  const AppSettingPage({Key? key}) : super(key: key);

  @override
  AppSettingPageState createState() => AppSettingPageState();
}

class AppSettingPageState extends BaseState<AppSettingPage> {
  late String alarmYn;
  late String receiveOtherYn;

  @override
  void initState() {
    super.initState();

    setState(() {
      alarmYn = user.info.alarm_yn;
      receiveOtherYn = user.info.receive_other;
    });
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return true;
  }

  void changeSetting(_alarmYn, _receiveOtherYn) {
    showLoading();
    try {
      api
          .alarmSetting(user.info.access_token, _alarmYn, _receiveOtherYn)
          .then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            alarmYn = _alarmYn;
            receiveOtherYn = _receiveOtherYn;
          });

          user.info.alarm_yn = _alarmYn;
          user.info.receive_other = _receiveOtherYn;
          user.setInfo(user.info);
        } else {
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      onBack: onBackPressed,
      isLoading: isLoading,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SimpleHeader(
              title: LanguageService.trans('app_setting'),
              onBackPressed: onBackPressed,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        H16(
                          maxLine: 5,
                          weight: FW.medium,
                          text: LanguageService.trans('decapet_notifications'),
                        ),
                        SizedBox(height: 10),
                        H12(
                          maxLine: 5,
                          weight: FW.medium,
                          color: AppColor_GrayText,
                          align: TextAlign.left,
                          text: LanguageService.trans('use_decapet'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                    child: InkWell(
                      onTap: () {
                        changeSetting(
                            alarmYn == "y" ? "n" : "y", receiveOtherYn);
                      },
                      child: Image.asset(
                        alarmYn == "y"
                            ? "assets/ic_switch_on.png"
                            : "assets/ic_switch_off.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
