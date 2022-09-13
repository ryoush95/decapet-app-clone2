import 'package:decapet/helpers/transition.dart';
import 'package:decapet/pages/intro/login.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:sprintf/sprintf.dart';
import 'package:substring_highlight/substring_highlight.dart';

class PasswordCompleteFragment extends StatefulWidget {
  @override
  PasswordCompleteFragmentState createState() => PasswordCompleteFragmentState();
}

class PasswordCompleteFragmentState extends BaseState<PasswordCompleteFragment> {
  @override
  void initState() {
    super.initState();
  }

  void onPasswdResetComplete() {
    Navigator.push(
        context, SlideRightTransRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
      isLoading: isLoading,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: H16(
                text: LanguageService.trans("passwd_reset_complete"),
              ),
            ),
            Center (
              child: MainTextButton(
                text: LanguageService.trans("login_caption"),
                backgroundColor: AppColor_Primary,
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                height: 58,
                onPressed: () {
                  onPasswdResetComplete();
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
