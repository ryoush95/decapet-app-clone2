import 'dart:async';
import 'dart:io';

import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/components/image_with_button.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/outline_input.dart';
import 'package:decapet/pages/components/photo_dialog.dart';
import 'package:decapet/pages/items/image_text_item.dart';
import 'package:decapet/pages/review/photo_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sprintf/sprintf.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../components/simple_header.dart';

class WriteReceiptReviewPage extends StatefulWidget {
  final int medicalUid;
  final hospitalUid;
  int reviewId = 0;
  final String hospitalName;

  WriteReceiptReviewPage({
    Key? key,
    required this.medicalUid,
    required this.reviewId,
    required this.hospitalUid,
    required this.hospitalName,
  }) : super(key: key);

  @override
  WriteReceiptReviewState createState() => WriteReceiptReviewState();
}

class WriteReceiptReviewState extends BaseState<WriteReceiptReviewPage> {
  final imagePicker = ImagePicker();
  ReviewDto review = ReviewDto();

  bool isValid = false;
  List<String> leaveImageList = [];
  List<String> purposeList = [];
  List<String> originFeelingList = [];
  List<String> additionalFeelingList = [];

  var contentController = TextEditingController();

  List<TextEditingController> additionalFeelingControllers = [];
  List<Widget> _widgetOriginList = [];
  List<Widget> _widgetAdditionalList = [];

  bool isEdit = false;
  String title = LanguageService.trans("write_receipt_review");
  String bottom = LanguageService.trans("register_review");
  @override
  void initState() {
    super.initState();
    initFeelings();
    if (widget.reviewId != 0 || widget.medicalUid != 0) {
      initReview();
    }
  }

  void initFeelings() {
    feelingList.clear();
    feelings.clear();

    try {
      api.feeling_list(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            feelings = value.data!.list;

            feelingList.add(Feeling(image: "assets/ic_review1.png", feeling: feelings[0]));
            feelingList.add(Feeling(image: "assets/ic_review2.png", feeling: feelings[1]));
            feelingList.add(Feeling(image: "assets/ic_review3.png", feeling: feelings[2]));
            feelingList.add(Feeling(image: "assets/ic_review4.png", feeling: feelings[3]));
            feelingList.add(Feeling(image: "assets/ic_review5.png", feeling: feelings[4]));
            feelingList.add(Feeling(image: "assets/ic_review6.png", feeling: feelings[5]));
            feelingList.add(Feeling(image: "assets/ic_review7.png", feeling: feelings[6]));
            feelingList.add(Feeling(image: "assets/ic_review8.png", feeling: feelings[7]));
            feelingList.add(Feeling(image: "assets/ic_review9.png", feeling: feelings[8]));

            reCalFeelings();

            if (widget.reviewId != 0) {
              initReview();
            }
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

  void reCalFeelings() {
    _widgetOriginList.clear();
    _widgetAdditionalList.clear();

    feelingList.forEach((element) {
      _widgetOriginList.add(FeelingItem(
        image: element.image,
        onClick: () {
          setState(() {
            if (originFeelingList.contains(element.feeling)) {
              originFeelingList.remove(element.feeling);
            } else {
              originFeelingList.add(element.feeling);
            }
          });
          reCalFeelings();
          checkValid();
        },
        feeling: element.feeling,
        isChecked: originFeelingList.contains(element.feeling),
      ));
    });

    for (int i = 0; i < additionalFeelingList.length; i++) {
      _widgetAdditionalList.add(Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: AppColor_Gray,
              blurRadius: 5.0, // soften the shadow
            ),
          ],
          color: AppColor_Primary,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Image.asset('assets/character_smile2.png', width: 30),
                Positioned(
                  left: 15,
                  bottom: 0,
                  child: Image.asset('assets/ic_red_heart_on.png', width: 15, height: 15),
                )
              ],
            ),
            const SizedBox(width: 5),
            Flexible(
              flex: 1,
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
                style: AppTextStyle.PD(AppColor_White, 16, weight: FW.medium),
                controller: additionalFeelingControllers[i],
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    additionalFeelingList[i] = value;
                  });
                  checkValid();
                },
              ),
            )
          ],
        ),
      ));
    }
  }

  void initReview() {
    showLoading();
    try {
      api.check_review(user.info.access_token, widget.reviewId, widget.medicalUid).then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            review = value.data!;
            if (value.data!.review_images.isNotEmpty) {
              leaveImageList = value.data!.review_images.split(",");
            }

            if (value.data!.purpose.isNotEmpty) {
              purposeList = value.data!.purpose.split(",");
            }
            if (value.data!.feelings.isNotEmpty) {
              value.data!.feelings.split(",").forEach((item) {
                if (feelings.contains(item)) {
                  originFeelingList.add(item);
                } else {
                  additionalFeelingControllers.add(TextEditingController(text: item));
                  additionalFeelingList.add(item);
                }
              });
            }
            contentController.text = value.data!.description;
            checkValid();

            if (purposeList.isNotEmpty) {
              isEdit = true;
              title = LanguageService.trans("write_receipt_review1");
              bottom = LanguageService.trans("register_review1");
            } else {
              isEdit = false;
              title = LanguageService.trans("write_receipt_review");
              bottom = LanguageService.trans("register_review");
            }
          });
          reCalFeelings();
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  void onSelectPhoto(String type) {
    showDialog(
        context: context,
        builder: (context) {
          return PhotoDialog(onGallery: () => {getGalleryImageAndCrop(type)}, onCamera: () => {getCameraImageAndCrop(type)});
        });
  }

  void getGalleryImageAndCrop(String type) async {
    Navigator.pop(context);
    final image = await imagePicker.getImage(source: ImageSource.gallery);
    if (image == null) return;

    var croppedImage = await cropImage(image.path);
    if (croppedImage != null) {
      uploadFile(croppedImage, type);
    }
  }

  void getCameraImageAndCrop(String type) async {
    Navigator.pop(context);
    final image = await imagePicker.getImage(source: ImageSource.camera);
    if (image == null) return;

    var croppedImage = await cropImage(image.path);
    if (croppedImage != null) {
      uploadFile(croppedImage, type);
    }
  }

  void uploadFile(File uploadFile, String type) {
    showLoading();
    try {
      api.uploadFiles(
        user.info.access_token,
        [uploadFile],
      ).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            if (type == "medical") {
              review.receipt_image = res.data!.file_urls[0];
            } else {
              leaveImageList.add(res.data!.file_urls[0]);
            }
            checkValid();
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

  void checkValid() {
    setState(() {
      isValid = purposeList.isNotEmpty && (originFeelingList.length + additionalFeelingList.length) > 0 /*&& review.receipt_image.isNotEmpty && leaveImageList.isNotEmpty*/ && contentController.text.length >= 20;
    });
  }

  void onAddLeaveImage() {
    if (leaveImageList.length > 4) {
      showToast(LanguageService.trans("max_four_image"));
      return;
    }
    onSelectPhoto("leave");
  }

  void onLikeHospital() {
    String favoriteYn = review.favourite_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.setFavorite(user.info.access_token, widget.hospitalUid, favoriteYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          event.fire(LikeHospital(widget.hospitalUid, favoriteYn));
          setState(() {
            review.favourite_yn = favoriteYn;
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

  void onRegisterReview() {
    hideKeyboard();

    if (isValid == false) {
      return;
    }

    originFeelingList.addAll(additionalFeelingList);
    List<String> _leaveImages = [];
    leaveImageList.forEach((element) {
      _leaveImages.add(element.split("/").last);
    });

    showLoading();
    try {
      api.review_write(user.info.access_token, widget.medicalUid, purposeList.join(","), originFeelingList.join(","), review.receipt_image.split("/").last, _leaveImages.join(","), contentController.text, widget.hospitalUid, widget.reviewId).then((value) {
        hideLoading();
        if (value.result == 0) {
          if (isEdit) {
            showToast(LanguageService.trans("success_to_write_review1"));
          } else {
            showToast(LanguageService.trans("success_to_write_review"));
          }

          review.purpose = purposeList.join(",");
          review.feelings = originFeelingList.join(",");
          review.review_images = _leaveImages.join(",");
          review.description = contentController.text;
          event.fire(ReviewUpdated(widget.reviewId, review));
          event.fire(ReviewWrite(widget.medicalUid));
          Navigator.of(context).pop();
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void addAdditionalFeeling() {
    additionalFeelingList.add("");
    additionalFeelingControllers.add(TextEditingController());

    setState(() {
      reCalFeelings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SimpleHeader(
              title: title,
              onBackPressed: onBackPressed,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: const BoxDecoration(
                        color: AppColor_White,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SubstringHighlight(
                                  text: sprintf(LanguageService.trans("did_you_like"), [widget.hospitalName]),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  term: widget.hospitalName,
                                  textStyle: AppTextStyle.PD(AppColor_BlackText, 24, weight: FW.bold, height: 1.5),
                                  textStyleHighlight: AppTextStyle.PD(AppColor_Primary, 24, weight: FW.bold, underline: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Stack(
                              //   children: [
                              //     Image.asset('assets/character_smile2.png', width: 30, height: 30),
                              //     Positioned(
                              //       left: 15,
                              //       bottom: 0,
                              //       child: Image.asset('assets/ic_red_heart_on.png', width: 15, height: 15),
                              //     )
                              //   ],
                              // ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          H16(
                            text: LanguageService.trans("click_comment"),
                            color: AppColor_36383C.withOpacity(0.6),
                            height: 1.5,
                            weight: FW.medium,
                            align: TextAlign.left,
                            maxLine: 2,
                          ),
                          const SizedBox(height: 30),
                          Stack(children: [
                            MainTextButton(
                              width: 170,
                              height: 53,
                              text: "      " + LanguageService.trans("i_like_hospital"),
                              backgroundColor: review.favourite_yn == "y" ? AppColor_Primary : AppColor_GrayBackround,
                              style: AppTextStyle.PD(review.favourite_yn == "y" ? Colors.white : AppColor_GrayText, 16, weight: FW.bold),
                              onPressed: onLikeHospital,
                            ),
                            Positioned(
                              left: 20,
                              top: 13,
                              child: review.favourite_yn == "y" ? Image.asset('assets/ic_red_heart_on.png', width: 25, height: 25) : Image.asset('assets/ic_red_heart_off.png', width: 25, height: 25),
                            )
                          ]),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Container(
                      height: 5,
                      color: AppColor_GrayBackround,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColor_White,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H24B(
                            text: LanguageService.trans("purpose_of_visit"),
                            color: AppColor_BlackText,
                            height: 1.1,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              H16(
                                text: LanguageService.trans("purpose_comment"),
                                color: AppColor_36383C.withOpacity(0.6),
                                height: 1.5,
                                weight: FW.medium,
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
                          const SizedBox(height: 30),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ImgWithButton(
                                      text: LanguageService.trans("diagnosis"),
                                      maxLine: 2,
                                      imagePath: 'assets/inventory_black_24dp.png',
                                      color: purposeList.contains("diagnosis") ? AppColor_White : AppColor_Primary,
                                      image_color: purposeList.contains("diagnosis") ? AppColor_White : AppColor_Primary,
                                      bg_color: purposeList.contains("diagnosis") ? AppColor_Primary : AppColor_White,
                                      onPressed: () {
                                        setState(() {
                                          if (purposeList.contains("diagnosis")) {
                                            purposeList.remove("diagnosis");
                                          } else {
                                            purposeList.add("diagnosis");
                                          }
                                        });
                                        checkValid();
                                      }),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ImgWithButton(
                                    text: LanguageService.trans("supplies"),
                                    imagePath: 'assets/local_mall_black_24dp.png',
                                    image_color: purposeList.contains("supplies") ? AppColor_White : AppColor_Blue_Dart,
                                    color: purposeList.contains("supplies") ? AppColor_White : AppColor_Blue_Dart,
                                    bg_color: purposeList.contains("supplies") ? AppColor_Blue_Dart : AppColor_White,
                                    onPressed: () {
                                      setState(() {
                                        if (purposeList.contains("supplies")) {
                                          purposeList.remove("supplies");
                                        } else {
                                          purposeList.add("supplies");
                                        }
                                      });
                                      checkValid();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ImgWithButton(
                                    text: LanguageService.trans("hotel"),
                                    imagePath: 'assets/luggage_black_24dp.png',
                                    color: purposeList.contains("hotel") ? AppColor_White : AppColor_Yellow,
                                    bg_color: purposeList.contains("hotel") ? AppColor_Yellow : AppColor_White,
                                    image_color: purposeList.contains("hotel") ? AppColor_White : AppColor_Yellow,
                                    onPressed: () {
                                      setState(() {
                                        if (purposeList.contains("hotel")) {
                                          purposeList.remove("hotel");
                                        } else {
                                          purposeList.add("hotel");
                                        }
                                      });
                                      checkValid();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ImgWithButton(
                                    text: LanguageService.trans("beauty"),
                                    imagePath: 'assets/pets_black_24dp.png',
                                    color: purposeList.contains("beauty") ? AppColor_White : AppColor_Purple,
                                    bg_color: purposeList.contains("beauty") ? AppColor_Purple : AppColor_White,
                                    image_color: purposeList.contains("beauty") ? AppColor_White : AppColor_Purple,
                                    onPressed: () {
                                      setState(() {
                                        if (purposeList.contains("beauty")) {
                                          purposeList.remove("beauty");
                                        } else {
                                          purposeList.add("beauty");
                                        }
                                      });
                                      checkValid();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // height: double.infinity,
                      // width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      decoration: BoxDecoration(
                        color: AppColor_White,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H24B(
                            text: LanguageService.trans("do_you_like"),
                            color: AppColor_BlackText,
                            height: 1.1,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              H16(
                                text: LanguageService.trans("do_you_like_comment"),
                                color: Colors.black54,
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
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: AppColor_GrayBackround,
                            ),
                            child: SingleChildScrollView(
                                padding: EdgeInsets.all(20),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width - 80,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          H14(text: LanguageService.trans("feelings")),
                                          const SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: _widgetOriginList,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(width: 5),
                                    Container(
                                      width: MediaQuery.of(context).size.width - 80,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        H14(text: LanguageService.trans("additional_input")),
                                        const SizedBox(height: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: _widgetAdditionalList,
                                        ),
                                        Container(
                                            width: double.maxFinite,
                                            padding: const EdgeInsets.only(top: 10),
                                            child: ImgWithButton(text: LanguageService.trans("additional_question"), imagePath: "assets/add_circle_black_24dp.png", color: AppColor_BlackText, bg_color: AppColor_White, font_size: 16.0, weight: FW.medium, onPressed: addAdditionalFeeling)),
                                      ]),
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Container(
                      height: 5,
                      color: AppColor_GrayBackround,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColor_White,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H24B(
                            text: LanguageService.trans("register_your_receipt"),
                            color: AppColor_BlackText,
                            height: 1.1,
                            maxLine: 2,
                          ),
                          const SizedBox(height: 10),
                          H16(
                            text: LanguageService.trans("register_your_receipt_comment"),
                            color: AppColor_36383C.withOpacity(0.6),
                            height: 1.5,
                            maxLine: 3,
                            weight: FW.medium,
                            align: TextAlign.left,
                          ),
                          const SizedBox(height: 28),
                          MainTextButton(
                            text: review.receipt_image.isNotEmpty ? LanguageService.trans("choose_again") : LanguageService.trans("add_receipt"),
                            backgroundColor: AppColor_BlackText,
                            style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                            height: 53,
                            width: 160,
                            onPressed: () {
                              onSelectPhoto("medical");
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: review.receipt_image.isNotEmpty,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, SlideRightTransRoute(builder: (context) => PhotoViewPage(img: review.receipt_image)));
                                },
                                child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: ClipPath(
                                      clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                                      child: ExtendedImage(
                                        image: NetworkImage(review.receipt_image),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColor_White,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H24B(
                            text: LanguageService.trans("leave_review"),
                            color: AppColor_BlackText,
                            height: 1.1,
                            maxLine: 2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImgWithButton(
                                text: LanguageService.trans("add_photo"),
                                imagePath: "assets/camera_alt_black_24dp.png",
                                image_color: AppColor_Hint,
                                onPressed: () {
                                  setState(() {
                                    onAddLeaveImage();
                                  });
                                  checkValid();
                                },
                                enable_border: true,
                              ),
                              const SizedBox(width: 10),
                              H16(
                                text: LanguageService.trans("max_4"),
                                color: AppColor_Hint,
                                weight: FW.medium,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: leaveImageList.isNotEmpty,
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 150,
                                      width: 150,
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context, SlideRightTransRoute(builder: (context) => PhotoViewPage(img: leaveImageList[index])));
                                            },
                                            child: ClipPath(
                                              clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                                              child: ExtendedImage(
                                                image: NetworkImage(leaveImageList[index]),
                                                height: 150,
                                                width: 150,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          // Image.network(
                                          //   leaveImageList[index],
                                          //   height: 150,
                                          //   width: 150,
                                          //   fit: BoxFit.fill,
                                          // ),
                                          Positioned(
                                            right: 10,
                                            top: 10,
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    leaveImageList.removeAt(index);
                                                    checkValid();
                                                  });
                                                },
                                                child: Icon(Icons.delete)),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: leaveImageList.length),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              H16(
                                text: "병원 이용에 대한 만족도나 느낌을 적어주세요.",
                                color: Colors.black54,
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
                          const SizedBox(height: 6),
                          Container(
                            height: 124,
                            // padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppColor_GrayBackround),
                            child: OutlineInput(
                              maxLine: 100,
                              maxLength: 500,
                              size: 16.0,
                              weight: FW.regular,
                              borderRadius: 10.0,
                              // style: AppTextStyle.PD(AppColor_Intro_Description, 16, weight: FW.regular, height: 1.5),
                              controller: contentController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              onChanged: (value) {
                                checkValid();
                              },
                              placeholder: LanguageService.trans('leave_review_comment'),
                              // hintColor: AppColor_Hint,
                              // decoration:
                              //     InputDecoration(hintMaxLines: 20, hintText: LanguageService.trans('leave_review_comment'), hintStyle: AppTextStyle.PD(AppColor_Hint, 16, weight: FW.regular, height: 1.5), counterText: contentController.text.length.toString() + " / 500", border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [H14(text: contentController.text.length.toString() + " / 500", weight: FW.medium, color: AppColor_GrayText)],
                          ),
                          const SizedBox(
                            height: 55,
                          ),
                          MainTextButton(
                            text: bottom,
                            backgroundColor: AppColor_Primary,
                            style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                            height: 58,
                            disable: !isValid,
                            disableBackground: !isValid ? AppColor_Primary_Disable : Colors.transparent,
                            onPressed: () {
                              onRegisterReview();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
