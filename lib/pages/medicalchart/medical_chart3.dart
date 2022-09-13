//add by hch
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:flutter/material.dart';

import '../components/h16.dart';
import '../components/main_text_button.dart';

class MedicalChartPage3 extends StatefulWidget {
  final int petUid;
  final String symptom;
  final int hospitalUid;

  MedicalChartPage3({Key? key, required this.petUid, required this.symptom, required this.hospitalUid}) : super(key: key);

  @override
  MedicalChartPage3State createState() => MedicalChartPage3State();
}

class MedicalChartPage3State extends BaseState<MedicalChartPage3> {
  bool isValid = false;
  var contentController1 = TextEditingController();
  var contentController2 = TextEditingController();
  var contentController3 = TextEditingController();
  var contentController4 = TextEditingController();
  var contentController5 = TextEditingController();

  String veterinarian = "";
  String vet_registration_number = "";
  String description = "";
  String prescription = "";
  String disease = "";

  bool isValidWritten = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void checkValid() {
    setState(() {
      isValid = /*veterinarian.isNotEmpty && vet_registration_number.isNotEmpty && */ description.isNotEmpty && prescription.isNotEmpty && disease.isNotEmpty;
    });
  }

  void onLeaveMessage() {
    Navigator.pop(context);
  }

  void onListenAndWrote() {
    setState(() {
      isValidWritten = false;
    });
  }

  void onWritten() {
    setState(() {
      isValidWritten = true;
    });
  }

  void onRegister() {
    if (!isValid) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    showLoading();
    try {
      api.add_chart(user.info.access_token, isSick, widget.symptom, widget.hospitalUid, veterinarian, vet_registration_number, description, prescription, isValidWritten ? 0 : 1, widget.petUid, disease).then((value) {
        hideLoading();
        if (value.result == 0) {
          showToast(LanguageService.trans("success_to_write_chart"));
          event.fire(ChangeRecord());
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
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
      isAvoidResize: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleHeader(
            title: LanguageService.trans("create_medical_chart"),
            onBackPressed: onBackPressed,
          ),
          const SizedBox(height: 10),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  H18(
                    text: LanguageService.trans("fill_info"),
                  ),
                  const SizedBox(height: 32),
                  H16(
                    text: LanguageService.trans("vet_teacher"),
                    weight: FW.medium,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: contentController1,
                    // keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyle.PD(AppColor_BlackText, 14, weight: FW.medium),
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: LanguageService.trans("license_input"),
                      hintStyle: AppTextStyle.PD(AppColor_Gray, 14, weight: FW.medium),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor_Selector_Border),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor_BlackText),
                      ),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    // maxLines: 1,
                    onChanged: (text) => {vet_registration_number = text, checkValid()},
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: contentController2,
                    // keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyle.PD(AppColor_BlackText, 14, weight: FW.medium),
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: LanguageService.trans("veter_input"),
                      hintStyle: AppTextStyle.PD(AppColor_Gray, 14, weight: FW.medium),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor_Selector_Border),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor_BlackText),
                      ),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    // maxLines: 1,
                    onChanged: (text) => {veterinarian = text, checkValid()},
                  ),
                  const SizedBox(height: 42),
                  Row(
                    children: [
                      H16(
                        text: LanguageService.trans("veter_advice"),
                        weight: FW.medium,
                        height: 1.5,
                      ),
                      H16(
                        text: "*",
                        weight: FW.medium,
                        color: AppColor_Primary,
                        height: 1.5,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(color: AppColor_Light_Gray, borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      controller: contentController3,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      style: AppTextStyle.PD(AppColor_BlackText, 14, weight: FW.medium),
                      decoration: InputDecoration(counterText: "", hintText: LanguageService.trans("veter_write"), hintStyle: AppTextStyle.PD(AppColor_Gray, 14, weight: FW.medium), border: InputBorder.none, focusedBorder: InputBorder.none),
                      onEditingComplete: () {
                        onLeaveMessage();
                      },
                      maxLines: 5,
                      onChanged: (text) => {description = text, checkValid()},
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      H16(
                        text: LanguageService.trans("Diagnosis"),
                        weight: FW.medium,
                        height: 1.5,
                      ),
                      H16(
                        text: "*",
                        weight: FW.bold,
                        color: AppColor_Primary,
                        height: 1.5,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: contentController4,
                    // keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyle.PD(AppColor_BlackText, 14, weight: FW.medium),
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: LanguageService.trans("diagnosis_input"),
                      hintStyle: AppTextStyle.PD(AppColor_Gray, 14, weight: FW.medium),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor_Selector_Border),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor_BlackText),
                      ),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    // maxLines: 3,
                    onChanged: (text) => {disease = text, checkValid()},
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      H16(
                        text: LanguageService.trans("pre_future_plans"),
                        weight: FW.medium,
                        height: 1.5,
                      ),
                      H16(
                        text: "*",
                        weight: FW.bold,
                        color: AppColor_Primary,
                        height: 1.5,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(color: AppColor_Light_Gray, borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      controller: contentController5,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      style: AppTextStyle.PD(AppColor_BlackText, 14, weight: FW.medium),
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: LanguageService.trans("plans_input"),
                        hintStyle: AppTextStyle.PD(AppColor_Gray, 14, weight: FW.medium),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onEditingComplete: () {
                        onLeaveMessage();
                      },
                      maxLines: 5,
                      onChanged: (text) => {prescription = text, checkValid()},
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      H16(
                        text: LanguageService.trans("consult_content"),
                        weight: FW.medium,
                        height: 1.5,
                        maxLine: 2,
                        align: TextAlign.left,
                      ),
                      H16(
                        text: "*",
                        weight: FW.bold,
                        color: AppColor_Primary,
                        height: 1.5,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(height: 5),
                  MainTextButton(
                    height: 52.0,
                    text: LanguageService.trans("listen_wrote"),
                    style: AppTextStyle.PD(isValidWritten ? Colors.black26 : Colors.blue, 16, weight: FW.bold),
                    showBorder: isValidWritten ? false : true,
                    borderColor: isValidWritten ? Colors.transparent : Colors.lightBlueAccent,
                    backgroundColor: isValidWritten ? AppColor_Light_Gray : AppColor_Light_Blue,
                    onPressed: () {
                      onListenAndWrote();
                    },
                  ),
                  const SizedBox(height: 10),
                  MainTextButton(
                    height: 52.0,
                    text: LanguageService.trans("written_veter"),
                    backgroundColor: !isValidWritten ? AppColor_Light_Gray : AppColor_Light_Blue,
                    style: AppTextStyle.PD(!isValidWritten ? Colors.black26 : Colors.blue, 16, weight: FW.bold),
                    showBorder: !isValidWritten ? false : true,
                    borderColor: !isValidWritten ? Colors.transparent : Colors.lightBlueAccent,
                    //width: 350,
                    onPressed: () {
                      onWritten();
                    },
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: MainTextButton(
                      text: LanguageService.trans("reg_medicalchart"),
                      backgroundColor: Colors.blue,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                      disable: !isValid,
                      disableBackground: !isValid ? AppColor_Primary_Disable : Colors.transparent,
                      //width: 350,
                      height: 58,
                      onPressed: () {
                        onRegister();
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
