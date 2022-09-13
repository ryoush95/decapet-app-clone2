import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/pages/components/radio_item.dart';
import 'package:decapet/pages/components/radio_selecter.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/category_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/underline_input.dart';
import 'package:decapet/pages/components/selector.dart';

class FindIdFragment extends StatefulWidget {
  final void Function(int code) onSendCode;

  const FindIdFragment({Key? key, required this.onSendCode, }) : super(key: key);

  @override
  FindIdFragmentState createState() => FindIdFragmentState();
}

class FindIdFragmentState extends BaseState<FindIdFragment> {
  var nameInputController = TextEditingController();
  var agencyInputController = TextEditingController();
  var phoneInputController = TextEditingController();
  String registered_name = "";
  String phone_number = "";
  bool isValid = false;

  List<RadioItemData> carrierList = [
    RadioItemData(item_id: 0, item_name: 'item1', item_selected: false),
    RadioItemData(item_id: 0, item_name: 'item2', item_selected: false),
    RadioItemData(item_id: 0, item_name: 'item3', item_selected: false),
    RadioItemData(item_id: 0, item_name: 'item4', item_selected: false),
    RadioItemData(item_id: 0, item_name: 'item5', item_selected: false),
    RadioItemData(item_id: 0, item_name: 'item6', item_selected: false),
  ];

  String carrier = "";

  @override
  void initState() {
    super.initState();
  }

  void checkValid() {
    setState(() {
      isValid = registered_name.isNotEmpty && phone_number.length == 11;
    });
  }

  void onSendVerifcationCode() {
    if (!isValid) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading();
    try {
      api.request_cert_key(phone_number, registered_name, "").then((value) {
        hideLoading();
        if (value.result == 0) {
          tempPhone = phone_number;
          widget.onSendCode(1);
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
        isAvoidResize: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              H14(
                text: LanguageService.trans("name"),
                weight: FW.medium,
                color: AppColor_Input_Title,
              ),
              UnderlineInput(
                controller: nameInputController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                placeholder: LanguageService.trans("enter_your_name"),
                onChanged: (text) => {registered_name = text, checkValid()},
              ),
              const SizedBox(height: 40),
              // H14(
              //   text: LanguageService.trans("news_agency"),
              //   weight: FW.medium,
              //   color: AppColor_Input_Title,
              // ),
              // RadioSelector(
              //     selectedCategory: '',
              //     categoryList: carrierList,
              //     onSelect: (selectedIndex) {
              //       setState(() {
              //         carrier = carrierList[selectedIndex].item_name;
              //       });
              //       checkValid();
              //     },
              //     hint: LanguageService.trans("select_carrier")),
              // const SizedBox(height: 40),
              H14(
                text: LanguageService.trans("phone"),
                weight: FW.medium,
                color: AppColor_Input_Title,
              ),
              UnderlineInput(
                maxLength: 11,
                controller: phoneInputController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                placeholder: LanguageService.trans("enter_phone_number"),
                onEditingComplete: () => {onSendVerifcationCode()},
                onChanged: (text) => {phone_number = text, checkValid()},
              ),
              Expanded(child:Container()),
              Center(
                child: MainTextButton(
                  text: LanguageService.trans("send_verification_code"),
                  backgroundColor: AppColor_Primary,
                  style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                  height: 58,
                  disable: !isValid,
                  disableBackground: !isValid
                      ? AppColor_Primary_Disable
                      : Colors.transparent,
                  onPressed: () {
                    onSendVerifcationCode();
                  },
                ),
              ),
              const SizedBox(height: 20,),
            ],
          )
        ));
  }
}
