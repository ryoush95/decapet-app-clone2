import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/intro/login.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:substring_highlight/substring_highlight.dart';

class RegisteredFragment extends StatefulWidget {
  @override
  RegisteredFragmentState createState() => RegisteredFragmentState();
}

class RegisteredFragmentState extends BaseState<RegisteredFragment> {
  // String registered_name = 'ygj0224';
  @override
  void initState() {
    super.initState();
  }

  void onLogIn() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => LoginPage()));
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
              child: SubstringHighlight(
                text: sprintf(LanguageService.trans("registered_message"), [tempId]),
                term: tempId,
                textStyle: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.medium, height: 1.5),
                textStyleHighlight: AppTextStyle.PD(AppColor_Primary, 16, weight: FW.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: MainTextButton(
                text: LanguageService.trans("login_caption"),
                backgroundColor: AppColor_Primary,
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                height: 58,
                onPressed: () {
                  onLogIn();
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
