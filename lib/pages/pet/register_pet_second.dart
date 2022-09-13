import 'dart:io';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/photo_dialog.dart';
import 'package:decapet/pages/components/underline_input.dart';
import 'package:decapet/pages/pet/register_pet_third.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../components/simple_header.dart';

class RegisterPetSecondPage extends StatefulWidget {
  @override
  RegisterPetSecondPageState createState() => RegisterPetSecondPageState();
}

class RegisterPetSecondPageState extends BaseState<RegisterPetSecondPage> {
  String imageUrl = "";
  String registrationNumber = "";
  final imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onNext() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (registrationNumber.isEmpty || imageUrl.isEmpty) {
      return;
    }

    Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => RegisterPetThirdPage(
                  imageUrl: imageUrl.split("/").last,
                  registrationNumber: registrationNumber,
                )));
  }

  void onSelectPhoto() {
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
        context: context,
        builder: (context) {
          return PhotoDialog(onGallery: getGalleryImageAndCrop, onCamera: getCameraImageAndCrop);
        });
  }

  void getGalleryImageAndCrop() async {
    Navigator.pop(context);
    final image = await imagePicker.getImage(source: ImageSource.gallery);
    if (image == null) return;

    var croppedImage = await cropImage(image.path);
    if (croppedImage != null) {
      uploadFile(croppedImage);
    }
  }

  void getCameraImageAndCrop() async {
    Navigator.pop(context);
    final image = await imagePicker.getImage(source: ImageSource.camera);
    if (image == null) return;

    var croppedImage = await cropImage(image.path);
    if (croppedImage != null) {
      uploadFile(croppedImage);
    }
  }

  void uploadFile(File uploadFile) {
    showLoading();
    try {
      api.uploadFiles(
        user.info.access_token,
        [uploadFile],
      ).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            imageUrl = res.data!.file_urls[0];
          });
        } else {
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  Future<File?> cropImage(String imagePath) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(toolbarTitle: LanguageService.trans('image_crop'), toolbarColor: Colors.white, toolbarWidgetColor: Colors.black, initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
    );
    return croppedFile;
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return PageLayout(
      isLoading: isLoading,
      isAvoidResize: false,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleHeader(
            title: LanguageService.trans("register_your_pet"),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: Container(
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: [
                    Container(
                      //height: (MediaQuery.of(context).size.height - 100),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H16(
                            text: LanguageService.trans("register_second_pet_contents1"),
                            weight: FW.bold,
                            maxLine: 2,
                            height: 1.9,
                            align: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          Stack(
                            children: [
                              Visibility(
                                visible: imageUrl.isEmpty,
                                child: InkWell(
                                  onTap: onSelectPhoto,
                                  child: Container(
                                    height: 200,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(border: Border.all(color: AppColor_Selector_Border, width: 1.0), borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 80),
                                        Image.asset("assets/camera_alt_black_24dp.png", width: 20),
                                        const SizedBox(height: 10),
                                        H14(
                                          text: LanguageService.trans("add_description_photo"),
                                          weight: FW.medium,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: imageUrl.isNotEmpty,
                                  child: Container(
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: ExtendedImage(
                                              image: NetworkImage(imageUrl),
                                              width: double.infinity,
                                              height: 200,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: onSelectPhoto,
                                              child: Container(
                                                margin: const EdgeInsets.only(top: 15, right: 20),
                                                child: Image.asset("assets/camera_alt_black_24dp.png", width: 20),
                                              ),
                                            )),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 30),
                          H14(
                            text: LanguageService.trans("register_second_pet_contents2"),
                          ),
                          const SizedBox(height: 10),
                          UnderlineInput(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () => onNext(),
                            onChanged: (text) {
                              setState(() {
                                registrationNumber = text;
                              });
                            },
                            placeholder: LanguageService.trans("register_second_pet_contents3"),
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MainTextButton(
                        text: LanguageService.trans("next"),
                        backgroundColor: AppColor_Primary,
                        style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                        //width: 360,
                        height: 58,
                        disable: registrationNumber.isEmpty || imageUrl.isEmpty,
                        disableBackground: registrationNumber.isNotEmpty && imageUrl.isNotEmpty ? AppColor_Primary : AppColor_Primary_Disable,
                        onPressed: () {
                          onNext();
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
