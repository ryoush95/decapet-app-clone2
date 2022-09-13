import 'dart:io';
import 'package:decapet/global/app_api.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_get_it.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/photo_dialog.dart';
import 'package:decapet/pages/review/photo_view.dart';
import 'package:decapet/stores/user_info_store.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/**
 * 동물 등록증
 */
class AnimalImgDialog extends StatefulWidget {
  final PetDto item;

  AnimalImgDialog({Key? key, required this.item}) : super(key: key);

  @override
  _AnimalImgDialogState createState() => _AnimalImgDialogState();
}

class _AnimalImgDialogState extends State<AnimalImgDialog> {
  bool bCheck = false;
  final imagePicker = ImagePicker();
  final Api api = getIt<Api>();
  final user = getIt<UserInfoStore>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
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
    setState(() {
      isLoading = true;
    });
    try {
      api.uploadPetImage(user.info.access_token, widget.item.id, uploadFile, 1).then((res) {
        setState(() {
          isLoading = false;
        });
        if (res.result == 0) {
          setState(() {
            widget.item.registration_image = res.data!.registration_image;
          });
        } else {
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      setState(() {
        isLoading = false;
      });
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
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 367,
            padding: const EdgeInsets.fromLTRB(25, 32, 25, 0),
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25), bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)), color: Colors.white),
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
                            onSelectPhoto();
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
        }));
    ;
  }
}
