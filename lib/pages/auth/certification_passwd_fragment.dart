import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/underline_input.dart';

class CertificationPasswdFragment extends StatefulWidget {
  final void Function(int code) onSendCode;

  const CertificationPasswdFragment({Key? key, required this.onSendCode})
      : super(key: key);
  @override
  CertificationPasswdFragmentState createState() => CertificationPasswdFragmentState();
}

class CertificationPasswdFragmentState extends BaseState<CertificationPasswdFragment> {

  var certificationInputController = TextEditingController();
  String verification_code = "";
  bool isValid = false;
  @override
  void initState() {
    super.initState();
  }

  void checkValid() {
    if (verification_code.isEmpty ) {
      setState(() {
        isValid = false;
      });
    } else {
      setState(() {
        isValid = true;
      });
    }
  }

  void onFindPasswd() {
    if (!isValid) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading();
    try {
      api.check_cert_key(tempPhone, verification_code).then((value) {
        hideLoading();
        if (value.result == 0) {
          widget.onSendCode(2);
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
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
              H14(
                text: LanguageService.trans("certification_input"),
                weight: FW.medium,
                color: AppColor_Input_Title,
              ),
              UnderlineInput(
                controller: certificationInputController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => onFindPasswd(),
                placeholder: LanguageService.trans("verification_code_hint"),
                onChanged: (text) => {verification_code = text, checkValid()},
              ),

              Expanded(child:Container()),
              Center (
                child: MainTextButton(
                  text: LanguageService.trans("find_passwd"),
                  backgroundColor: AppColor_Primary,
                  style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                  height: 58,
                  disable: !isValid,
                  disableBackground: !isValid
                      ? AppColor_Primary_Disable
                      : Colors.transparent,
                  onPressed: () {
                    onFindPasswd();
                  },
                ),
              ),
              const SizedBox(height: 20,),
            ],
          )),
    );
  }
}
