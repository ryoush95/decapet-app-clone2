import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/app_checkbox.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/selector1.dart';
import 'package:decapet/pages/components/underline_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../components/simple_header.dart';
import '../tab_main.dart';

class RegisterPetThirdPage extends StatefulWidget {
  RegisterPetThirdPage({Key? key, required this.imageUrl, required this.registrationNumber}) : super(key: key);

  final String imageUrl;
  final String registrationNumber;

  @override
  RegisterPetThirdPageState createState() => RegisterPetThirdPageState();
}

class RegisterPetThirdPageState extends BaseState<RegisterPetThirdPage> {
  bool isValid = false;

  String name = "";
  String animalType = "";
  String breed = "";
  String gender = "";
  String neuteringStatus = "";
  String personality = "";
  String disease = "";
  String wish = "";
  DateTime? birthday;

  List<String> speciesList = ['dog', 'cat'];
  List<String> speciesLangList = [LanguageService.trans('dog'), LanguageService.trans('cat')];

  List<String> breedList = [];

  List<String> personalityList = [];
  var inputController = TextEditingController();
  String inputContent = "";

  @override
  void initState() {
    super.initState();
    loadPersonalityList();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void checkValid() {
    setState(() {
      isValid = name.isNotEmpty && animalType.isNotEmpty && gender.isNotEmpty && breed.isNotEmpty && gender.isNotEmpty && neuteringStatus.isNotEmpty && personality.isNotEmpty;
    });
  }

  void loadPersonalityList() {
    try {
      api.personality_list(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            personalityList = value.data!.list;
          });
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void getBreedList() {
    FocusScope.of(context).requestFocus(FocusNode());

    if (animalType.isEmpty) {
      return;
    }

    showLoading();
    try {
      api.breed_list(user.info.access_token, animalType).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            breedList.clear();
            breed = value.data!.list.isEmpty ? "" : value.data!.list.elementAt(0);
            // if (value.data!.list.length < 15) {
            //   breedList = value.data!.list;
            // } else {
            //   for (var i = 0; i < 15; i++) {
            //     breedList.add(value.data!.list.elementAt(i));
            //   }
            // }
            breedList = value.data!.list;
            breedList.add(LanguageService.trans("other1"));
          });
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void onSelectBirthday() {
    DatePicker.showDatePicker(context, showTitleActions: true, minTime: DateTime(1900), maxTime: DateTime(2100), onChanged: (date) {}, onConfirm: (date) {
      setState(() {
        birthday = date;
        checkValid();
      });
    }, currentTime: birthday, locale: LocaleType.ko);
  }

  void onRegister() {
    if (!isValid) {
      return;
    }

    if (breed == LanguageService.trans("other1")) {
      if (inputContent.isEmpty) {
        return showToast(LanguageService.trans("input_kind2"));
      }
      breed = breed.replaceAll(LanguageService.trans("other1"), inputContent);
    }

    showLoading();
    try {
      api.register_pet(user.info.access_token, widget.registrationNumber, widget.imageUrl, animalType, breed, gender, neuteringStatus, personality, disease, wish, 0, birthday == null ? "" : getDateFormatString(birthday!, "yyyy-M-d"), name).then((value) {
        hideLoading();
        if (value.result == 0) {
          showToast(LanguageService.trans("success_reg_pet"));
          Navigator.pushReplacement(context, SlideRightTransRoute(builder: (context) => TabMainPage()));
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
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans("register_your_pet"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        H16(
                          text: LanguageService.trans("register_pet_description"),
                          weight: FW.bold,
                          maxLine: 2,
                          height: 1.9,
                          align: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        H16(
                          text: LanguageService.trans("name"),
                          weight: FW.medium,
                          color: AppColor_Input_Title,
                        ),
                        const SizedBox(height: 10),
                        UnderlineInput(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          placeholder: LanguageService.trans("register_pet_name"),
                          height: 30,
                          onChanged: (text) => {name = text, checkValid()},
                        ),
                        const SizedBox(height: 20),
                        H16(
                          text: LanguageService.trans("kind1"),
                          weight: FW.medium,
                        ),
                        DropdownButtonFormField<String>(
                          itemHeight: 50,
                          icon: Image.asset('assets/ic_blue_down.png', width: 12),
                          hint: H16(text: LanguageService.trans(animalType).isEmpty ? LanguageService.trans("register_pet_species") : LanguageService.trans(animalType), weight: FW.medium, color: LanguageService.trans(animalType).isEmpty ? AppColor_Hint : AppColor_BlackText),
                          items: speciesLangList
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          isExpanded: false,
                          onChanged: (value) {
                            setState(() {
                              animalType = speciesList[speciesLangList.indexOf(value!)];
                              checkValid();
                              getBreedList();
                            });
                          },
                          style: AppTextStyle.PD(
                            AppColor_BlackText,
                            16,
                            weight: FW.medium,
                          ),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor_Selector_Border),
                            // borderRadius: BorderRadius.all(Radius.circular(12.0)
                          )),
                        ),
                        const SizedBox(height: 20),
                        H16(
                          text: LanguageService.trans("kind2"),
                          weight: FW.medium,
                        ),
                        DropdownButtonFormField<String>(
                          value: breed,
                          itemHeight: 50,
                          icon: Image.asset('assets/ic_blue_down.png', width: 12),
                          hint: H16(text: LanguageService.trans("register_pet_breed"), weight: FW.medium, color: AppColor_Hint),
                          items: breedList
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          isExpanded: false,
                          style: AppTextStyle.PD(
                            AppColor_BlackText,
                            16,
                            weight: FW.medium,
                          ),
                          onChanged: (value) {
                            setState(() {
                              breed = value!;
                            });
                          },
                          decoration: const InputDecoration(
                              // contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor_Selector_Border),
                            // borderRadius: BorderRadius.all(Radius.circular(12.0)
                          )),
                        ),
                        Visibility(
                          visible: breed == LanguageService.trans("other1"),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(top: 10),
                            child: UnderlineInput(
                              controller: inputController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              placeholder: LanguageService.trans("input_kind2"),
                              height: 50,
                              onChanged: (text) => {inputContent = text},
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        H16(
                          text: LanguageService.trans("gender"),
                          weight: FW.medium,
                        ),
                        const SizedBox(height: 15),
                        Row(children: [
                          Expanded(
                            child: AppCheckbox(
                                text: LanguageService.trans("male"),
                                checked: gender == "m",
                                onChecked: (checked) {
                                  setState(() {
                                    gender = "m";
                                    checkValid();
                                  });
                                }),
                          ),
                          Expanded(
                            child: AppCheckbox(
                                text: LanguageService.trans("female"),
                                checked: gender == "f",
                                onChecked: (checked) {
                                  setState(() {
                                    gender = "f";
                                    checkValid();
                                  });
                                }),
                          ),
                          Expanded(
                            child: AppCheckbox(
                                text: LanguageService.trans("unknow"),
                                checked: gender == "unknown",
                                onChecked: (checked) {
                                  setState(() {
                                    gender = "unknown";
                                    checkValid();
                                  });
                                }),
                          )
                        ]),
                        const SizedBox(height: 20),
                        H16(
                          text: LanguageService.trans("register_pet_sex"),
                          weight: FW.medium,
                        ),
                        const SizedBox(height: 15),
                        Row(children: [
                          Expanded(
                            child: AppCheckbox(
                                text: LanguageService.trans("did"),
                                checked: neuteringStatus == "yes",
                                onChecked: (checked) {
                                  setState(() {
                                    neuteringStatus = "yes";
                                    checkValid();
                                  });
                                }),
                          ),
                          Expanded(
                            child: AppCheckbox(
                                text: LanguageService.trans("didn't"),
                                checked: neuteringStatus == "no",
                                onChecked: (checked) {
                                  setState(() {
                                    neuteringStatus = "no";
                                    checkValid();
                                  });
                                }),
                          ),
                          Expanded(
                            child: AppCheckbox(
                                text: LanguageService.trans("unknow"),
                                checked: neuteringStatus == "unknown",
                                onChecked: (checked) {
                                  setState(() {
                                    neuteringStatus = "unknown";
                                    checkValid();
                                  });
                                }),
                          )
                        ]),
                        const SizedBox(height: 20),
                        H16(
                          text: LanguageService.trans("birthday"),
                          weight: FW.medium,
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: onSelectBirthday,
                          child: Container(
                            height: 25,
                            width: double.infinity,
                            child: H16(
                              align: TextAlign.start,
                              weight: FW.medium,
                              text: birthday != null ? getDateFormatString(birthday!, "yyyy-MM-dd") : "yyyy-MM-dd",
                              color: birthday != null ? AppColor_BlackText : AppColor_Hint,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(birthday == null ? 'assets/ic_blue_check.png' : 'assets/ic_circle_off.png', height: 22),
                              const SizedBox(width: 8),
                              Text(
                                LanguageService.trans("I_do_not_know"),
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.PD(AppColor_BlackText, 14, weight: FW.medium, height: 1),
                              )
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              birthday = null;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        H16(
                          text: LanguageService.trans("personality"),
                          weight: FW.medium,
                        ),
                        Selector1(
                            selectedCategory: personality,
                            categoryList: personalityList,
                            onSelect: (index) {
                              setState(() {
                                personality = personalityList[index];
                                checkValid();
                              });
                            },
                            hint: LanguageService.trans("register_pet_personality")),
                        const SizedBox(height: 20),
                        H16(
                          text: LanguageService.trans("register_pet_disease"),
                          weight: FW.medium,
                        ),
                        const SizedBox(height: 10),
                        UnderlineInput(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          placeholder: LanguageService.trans("register_pet_disease_name"),
                          height: 30,
                          onChanged: (text) {
                            disease = text;
                            checkValid();
                          },
                        ),
                        const SizedBox(height: 30),
                        H16(
                          text: LanguageService.trans("register_pet_decarpet_service"),
                          weight: FW.medium,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          maxLines: null,
                          style: AppTextStyle.PD(AppColor_BlackText, 16, weight: FW.medium),
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor_Selector_Border),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor_BlackText),
                            ),
                            hintMaxLines: 20,
                            hintText: LanguageService.trans('register_pet_decarpet_service_description'),
                            counterText: '',
                            hintStyle: AppTextStyle.PD(AppColor_Hint, 16, weight: FW.medium),
                          ),
                          onChanged: (text) {
                            wish = text;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MainTextButton(
                      text: LanguageService.trans("register_your_pet"),
                      backgroundColor: AppColor_Primary,
                      style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                      //width: 360,
                      height: 58,
                      disable: !isValid,
                      disableBackground: isValid ? AppColor_Primary : AppColor_Primary_Disable,
                      onPressed: onRegister,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
