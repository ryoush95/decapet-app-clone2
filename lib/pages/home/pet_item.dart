import 'dart:io';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/models/dto/inoculation_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/bloodtest/bloodtest_appointment_first.dart';
import 'package:decapet/pages/components/H26.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/main_text_button.dart';
import 'package:decapet/pages/components/photo_dialog.dart';
import 'package:decapet/pages/dialog/dlg_amimal_img.dart';
import 'package:decapet/pages/home/blood_test_result.dart';
import 'package:decapet/pages/home/treatment_chart.dart';
import 'package:decapet/pages/review/photo_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:decapet/pages/alarm/wait.dart';
import 'heartworm.dart';

class PetItem extends StatefulWidget {
  final PetDto item;
  final String guide;

  PetItem({
    Key? key,
    required this.item,
    required this.guide,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PetItemState();
  }
}

class PetItemState extends BaseState<PetItem> {
  String level = "";
  String levelImage = "";
  final imagePicker = ImagePicker();
  int type = 0;

  @override
  void initState() {
    super.initState();
    switch (widget.item.level) {
      case 'silver':
        level = LanguageService.trans("silver");
        levelImage = 'assets/silver.png';
        break;
      case 'gold':
        level = LanguageService.trans("gold");
        levelImage = 'assets/gold.png';
        break;
      case 'platinum':
        level = LanguageService.trans("platinum");
        levelImage = 'assets/platinum.png';
        break;
      case 'dia':
        level = LanguageService.trans("dia");
        levelImage = 'assets/dia.png';
        break;
      case 'bronze':
        level = LanguageService.trans("bronze");
        levelImage = 'assets/bronze.png';
        break;
      case 'iron':
        level = LanguageService.trans("iron");
        levelImage = 'assets/iron.png';
        break;
    }
  }

  void showAnimalRegDlg() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 367,
            padding: const EdgeInsets.fromLTRB(25, 32, 25, 0),
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LanguageService.trans("animal_registration_card"),
                        style: AppTextStyle.PD(AppColor_BlackText, 22, height: 1.0, weight: FW.bold),
                      ),
                      InkWell(
                        child: H16(
                          text: LanguageService.trans('close'),
                          weight: FW.medium,
                          color: AppColor_Primary,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                    width: MediaQuery.of(context).size.width - 48,
                    height: 220,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            type = 1;
                            //onSelectPhoto();
                            widget.item.registration_image = widget.item.pet_image;
                            setState(() {});
                          },
                          child: ClipPath(
                            clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                            child: ExtendedImage(
                              image: NetworkImage(widget.item.registration_image),
                              height: 220,
                              width: MediaQuery.of(context).size.width - 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: widget.item.registration_image.isNotEmpty && !widget.item.registration_image.contains("img_photo_default"),
                          child: Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, SlideRightTransRoute(builder: (context) => PhotoViewPage(img: widget.item.registration_image)));
                              },
                              child: Container(
                                width: 60,
                                height: 24,
                                decoration: const BoxDecoration(color: AppColor_Primary, borderRadius: BorderRadius.all(Radius.circular(6))),
                                child: Center(
                                  child: H14(
                                    text: LanguageService.trans('zoom_view'),
                                    weight: FW.regular,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: SizedBox(width: 10),
                    ),
                    Visibility(
                      visible: widget.item.registration_number.isNotEmpty,
                      child: H14(
                        text: LanguageService.trans('register_second_pet_contents2') + " : " + widget.item.registration_number,
                        weight: FW.medium,
                        color: AppColor_36383C.withOpacity(0.5),
                        align: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void goInoculationPage(String type, int petId, InoculationDto inoculation) {
    Navigator.push(
        context,
        SlideRightTransRoute(
          builder: (context) => HeartWormPage(type: type, animal_type: widget.item.animal_type, inoculation: inoculation, pet_uid: petId),
        ));
  }

  void showInoculationDlg(String type, String title, InoculationDto inoculation, int PetId) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H20(text: title, height: 1.5),
                    InkWell(
                      child: H20(
                        text: LanguageService.trans('close'),
                        weight: FW.medium,
                        color: AppColor_Primary,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              H14(
                text: LanguageService.trans("inoculation_date"),
                color: AppColor_GrayText,
              ),
              const SizedBox(height: 10),
              H18(
                text: getDateFormatString(DateTime.parse(inoculation.inoculation_date), "yMMMEd"),
              ),
              Visibility(
                visible: type != "rabies",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    H14(
                      text: LanguageService.trans("approximately"),
                      color: AppColor_GrayText,
                    ),
                    const SizedBox(height: 10),
                    H18(
                      text: inoculation.drug_name,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              MainTextButton(
                text: LanguageService.trans('add_inoculation_date'),
                style: AppTextStyle.PD(Colors.white, 18, weight: FW.bold),
                onPressed: () {
                  Navigator.of(context).pop();
                  goInoculationPage(type, widget.item.id, inoculation);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void onSelectPhoto() {
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
      api.uploadPetImage(user.info.access_token, widget.item.id, uploadFile, 0).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            if (type == 0) {
              widget.item.pet_image = res.data!.pet_image;
            } else if (type == 1) {
              widget.item.registration_image = res.data!.pet_image;
            }
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

  void onTest() {
    if (widget.item.level == 'iron' || (widget.item.bt_dt.isNotEmpty && widget.item.bt_percent < 100)) {
      return;
    }

    //예약을 하고 나면 비활성화되도록.다음 활성화까지 30일이 걸림. 예약 후 취소해도 30일 비활성화됨.
    if (widget.item.bt_created_at != "") {
      DateTime tempDate = DateTime.parse(widget.item.bt_created_at);
      int diffDays = tempDate.difference(DateTime.now()).inDays;
      diffDays = diffDays.abs();
      if (diffDays >= 0 && diffDays < 31) {
        diffDays = 30 - diffDays;
        showToast(diffDays.toString() + LanguageService.trans("rereservae_avaliable"));
        return;
      }
    }

    Navigator.push(context, SlideRightTransRoute(builder: (context) => Wait(/*item: widget.item*/)));
  }

  void onResult() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => BloodTestResultPage(petUid: widget.item.id)));
  }

  void onChart() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => Wait(/*petUid: widget.item.id, petName: widget.item.name, animaltype: widget.item.animal_type*/)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 80),
      //height: 320,
      margin: const EdgeInsets.only(left: 20, right: 15, top: 15, bottom: 15),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(color: AppColor_White, border: Border.all(color: Colors.transparent), borderRadius: const BorderRadius.all(Radius.circular(8)), boxShadow: const [BoxShadow(color: AppColor_Gray, blurRadius: 5.0)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(widget.item.animal_type == "cat" ? 'assets/ic_cat.png' : 'assets/ic_dog.png', width: 20, height: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      LanguageService.trans('unique_number') + widget.item.identy_number,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.PD(AppColor_GrayText, 12, weight: FW.regular),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  type = 0;
                  onSelectPhoto();
                },
                child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: Stack(
                      children: [
                        Visibility(
                          visible: widget.item.pet_image.isEmpty || widget.item.pet_image.contains("img_photo_default"),
                          child: Center(
                            child: Image.asset(
                              widget.item.animal_type == "cat" ? 'assets/ic_default_cat.png' : 'assets/ic_default_dog.png',
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: widget.item.pet_image.isNotEmpty && !widget.item.pet_image.contains("img_photo_default"),
                          child: ClipPath(
                            clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                            child: Image.network(
                              widget.item.pet_image,
                              fit: BoxFit.fill,
                              height: 244,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        H26(
                          text: level,
                          weight: FW.semi_bold,
                          align: TextAlign.left,
                          color: AppColor_GrayText,
                        ),
                        const SizedBox(width: 10),
                        Image.asset(levelImage, width: 30, height: 30),
                        Expanded(
                          child: Container(),
                        ),
                        JustTheTooltip(
                          isModal: true,
                          offset: 5,
                          child: Image.asset('assets/question_mark_black_24dp.png', width: 15, height: 15),
                          content: Container(
                            width: 300,
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              widget.guide,
                              style: AppTextStyle.PD(Colors.black54, 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    H16(
                      text: widget.item.name,
                      weight: FW.semi_bold,
                      align: TextAlign.left,
                      color: AppColor_BlackText,
                    ),
                    const SizedBox(height: 5),
                    H14(
                      text: widget.item.birth != '0000-00-00' ? widget.item.age.toString() + LanguageService.trans("sae") : LanguageService.trans("unknow"),
                      weight: FW.medium,
                      align: TextAlign.left,
                      color: AppColor_GrayText,
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 350,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: MainTextButton(
                    text: LanguageService.trans("animal_registration_card"),
                    backgroundColor: AppColor_Primary,
                    style: AppTextStyle.PD(Colors.white, 14, weight: FW.semi_bold),
                    radius: 5.0,
                    width: (MediaQuery.of(context).size.width - 120),
                    height: 35,
                    onPressed: () {
                      //showAnimalRegDlg();
                      showDialog(context: context, builder: (_) => AnimalImgDialog(item: widget.item));
                    },
                  ),
                ),
                const SizedBox(height: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: onTest,
                      child: Container(
                          width: (MediaQuery.of(context).size.width - 120),
                          height: 49,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: AppColor_Red)),
                          child: Stack(
                            children: [
                              Visibility(
                                visible: widget.item.bt_dt.isNotEmpty,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: widget.item.bt_percent,
                                      child: Container(
                                        height: 45,
                                        color: AppColor_Red.withOpacity(0.1),
                                      ),
                                    ),
                                    Expanded(
                                      flex: (100 - widget.item.bt_percent),
                                      child: Container(
                                        height: 45,
                                        color: Colors.transparent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 15),
                                  H16(
                                    text: LanguageService.trans('blood_draw'),
                                    weight: FW.medium,
                                    color: AppColor_Red,
                                    align: TextAlign.left,
                                  ),
                                  Expanded(child: Container()),
                                  Visibility(
                                    visible: widget.item.bt_dt.isEmpty,
                                    child: H16(
                                      // key: tooltip,
                                      text: LanguageService.trans("make_reserv"),
                                      weight: FW.bold,
                                      color: AppColor_Red,
                                      align: TextAlign.right,
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.item.bt_dt.isNotEmpty,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: H16(
                                        text: LanguageService.trans("d") + (widget.item.bt_dd >= 0 ? "-" : "") + widget.item.bt_dd.toString(),
                                        weight: FW.bold,
                                        color: AppColor_Red,
                                        align: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              )
                            ],
                          )),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        if (widget.item.rabies_dt.isEmpty) {
                          goInoculationPage("rabies", widget.item.id, InoculationDto());
                        } else {
                          showInoculationDlg("rabies", LanguageService.trans("rabies_vaccination"), InoculationDto(drug_id: 0, drug_name: "", inoculation_date: widget.item.rabies_dt), widget.item.id);
                        }
                      },
                      child: Container(
                          width: (MediaQuery.of(context).size.width - 120),
                          height: 49,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: AppColor_Primary)),
                          child: Stack(
                            children: [
                              Visibility(
                                visible: widget.item.rabies_dt.isNotEmpty,
                                child: Row(
                                  children: [
                                    Expanded(
                                      //flex: widget.item.rabies_percent,
                                      flex: getDDay1Pcercent(widget.item),
                                      child: Container(
                                        height: 45,
                                        color: AppColor_Primary.withOpacity(0.1),
                                      ),
                                    ),
                                    Expanded(
                                      //flex: (100 - widget.item.rabies_percent),
                                      flex: 100 - getDDay1Pcercent(widget.item),
                                      child: Container(
                                        height: 45,
                                        color: Colors.transparent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 15),
                                  H16(
                                    text: LanguageService.trans('rabies_vaccination'),
                                    weight: FW.medium,
                                    color: AppColor_Primary,
                                    align: TextAlign.left,
                                  ),
                                  Expanded(child: Container()),
                                  Visibility(
                                    visible: widget.item.rabies_dt.isEmpty,
                                    child: Image.asset('assets/add_circle_black_24dp.png', width: 15, height: 15),
                                  ),
                                  Visibility(
                                    visible: widget.item.rabies_dt.isNotEmpty,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: H16(
                                        //text: LanguageService.trans("d") + (widget.item.rabies_dd >= 0 ? "+" : "") + widget.item.rabies_dd.toString(),
                                        text: getDDay1(widget.item.rabies_dt),
                                        weight: FW.bold,
                                        color: AppColor_Primary,
                                        align: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              )
                            ],
                          )),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        if (widget.item.heartworm_dt.isEmpty) {
                          goInoculationPage("heartworm", widget.item.id, InoculationDto());
                        } else {
                          showInoculationDlg("heartworm", LanguageService.trans("heartworm"), InoculationDto(drug_id: widget.item.heartworm_drug_id, drug_name: widget.item.heartworm_drug_name, inoculation_date: widget.item.heartworm_dt), widget.item.id);
                        }
                      },
                      child: Container(
                          width: (MediaQuery.of(context).size.width - 120),
                          height: 49,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: AppColor_Primary)),
                          child: Stack(children: [
                            Visibility(
                              visible: widget.item.heartworm_dt.isNotEmpty,
                              child: Row(
                                children: [
                                  Expanded(
                                    //flex: widget.item.heartworm_percent,
                                    flex: getDDay2Pcercent(widget.item.heartworm_dt, widget.item.heartworm_drug_id),
                                    child: Container(
                                      height: 45,
                                      color: AppColor_Primary.withOpacity(0.1),
                                    ),
                                  ),
                                  Expanded(
                                    //flex: (100 - widget.item.heartworm_percent),
                                    flex: 100 - getDDay2Pcercent(widget.item.heartworm_dt, widget.item.heartworm_drug_id),
                                    child: Container(
                                      height: 45,
                                      color: Colors.transparent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 15),
                                H16(
                                  text: LanguageService.trans('heartworm'),
                                  weight: FW.medium,
                                  color: AppColor_Primary,
                                  align: TextAlign.left,
                                ),
                                Expanded(child: Container()),
                                Visibility(
                                  visible: widget.item.heartworm_dt.isEmpty,
                                  child: Image.asset('assets/add_circle_black_24dp.png', width: 15, height: 15),
                                ),
                                Visibility(
                                  visible: widget.item.heartworm_dt.isNotEmpty,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: H16(
                                      //text: LanguageService.trans("d") + (widget.item.heartworm_dd >= 0 ? "+" : "") + widget.item.heartworm_dd.toString(),
                                      text: getDDay2(widget.item.heartworm_dt, widget.item.heartworm_drug_id),
                                      weight: FW.bold,
                                      color: AppColor_Primary,
                                      align: TextAlign.left,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            )
                          ])),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        if (widget.item.ecto_dt.isEmpty) {
                          goInoculationPage("ectorparasite", widget.item.id, InoculationDto());
                        } else {
                          showInoculationDlg("ectorparasite", LanguageService.trans("ectoparasite"), InoculationDto(drug_id: widget.item.ecto_drug_id, drug_name: widget.item.ecto_drug_name, inoculation_date: widget.item.ecto_dt), widget.item.id);
                        }
                      },
                      child: Container(
                          width: (MediaQuery.of(context).size.width - 120),
                          height: 49,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, border: Border.all(color: AppColor_Primary)),
                          child: Stack(
                            children: [
                              Visibility(
                                visible: widget.item.ecto_dt.isNotEmpty,
                                child: Row(
                                  children: [
                                    Expanded(
                                      //flex: widget.item.ecto_percent,
                                      flex: getDDay2Pcercent(widget.item.ecto_dt, widget.item.ecto_drug_id),
                                      child: Container(
                                        height: 45,
                                        color: AppColor_Primary.withOpacity(0.1),
                                      ),
                                    ),
                                    Expanded(
                                      //flex: (100 - widget.item.ecto_percent),
                                      flex: 100 - getDDay2Pcercent(widget.item.ecto_dt, widget.item.ecto_drug_id),
                                      child: Container(
                                        height: 45,
                                        color: Colors.transparent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 15),
                                  H16(
                                    text: LanguageService.trans('ectoparasite'),
                                    weight: FW.medium,
                                    color: AppColor_Primary,
                                    align: TextAlign.left,
                                  ),
                                  Expanded(child: Container()),
                                  Visibility(
                                    visible: widget.item.ecto_dt.isEmpty,
                                    child: Image.asset('assets/add_circle_black_24dp.png', width: 15, height: 15),
                                  ),
                                  Visibility(
                                    visible: widget.item.ecto_dt.isNotEmpty,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: H16(
                                        //text: LanguageService.trans("d") + (widget.item.ecto_dd >= 0 ? "+" : "") + widget.item.ecto_dd.toString(),
                                        text: getDDay2(widget.item.ecto_dt, widget.item.ecto_drug_id),
                                        weight: FW.bold,
                                        color: AppColor_Primary,
                                        align: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              )
                            ],
                          )),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 5),
                        Expanded(
                          child: MainTextButton(
                            text: LanguageService.trans("child_treat_chart"),
                            backgroundColor: AppColor_Light_Blue,
                            style: AppTextStyle.PD(Colors.blue, 14, weight: FW.semi_bold),
                            radius: 5.0,
                            width: 120,
                            height: 34,
                            onPressed: onChart,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: MainTextButton(
                            text: LanguageService.trans("view_blood_result"),
                            backgroundColor: AppColor_Selector_Border.withOpacity(0.5),
                            style: AppTextStyle.PD(Colors.black, 14, weight: FW.semi_bold),
                            radius: 5.0,
                            width: 120,
                            height: 34,
                            onPressed: onResult,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
