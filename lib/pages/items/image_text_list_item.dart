import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/treatment_chart_item_dto.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/image_with_button.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/components/main_text_button.dart';

class ImageTextListDataItem {
  bool item_is_clicked;
  String item_name;
  String item_image_path;
  final void Function(String name, bool? value) onClick;

  ImageTextListDataItem(
      {required this.item_name,
      required this.item_image_path,
      required this.item_is_clicked,
      required this.onClick});
}

class ImageTextListData {
  String title;
  List<ImageTextListDataItem> data;

  ImageTextListData({required this.title, required this.data});
}

class ImageTextListItem extends StatefulWidget {
  final ImageTextListData item;

  ImageTextListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  ImageTextListItemState createState() => ImageTextListItemState();
}

class ImageTextListItemState extends BaseState<ImageTextListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 330,
            height: 380,
            decoration: BoxDecoration(
                color: AppColor_GrayBackround, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                H16(
                  text: LanguageService.trans(widget.item.title),
                  weight: FW.bold,
                  align: TextAlign.left,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: ImgWithButton(
                            text: widget.item.data[index].item_name,
                            imagePath: widget.item.data[index].item_image_path,
                            color: widget.item.data[index].item_is_clicked
                                ? AppColor_White
                                : AppColor_BlackText,
                            bg_color: widget.item.data[index].item_is_clicked
                                ? AppColor_Primary
                                : AppColor_White,
                            font_size: 16.0,
                            weight: FW.medium,
                            onPressed: () {
                              setState(() {
                                widget.item.data[index].item_is_clicked =
                                    !widget.item.data[index].item_is_clicked;
                              });
                              widget.item.data[index].onClick(widget.item.data[index].item_name, widget.item.data[index].item_is_clicked);
                            },
                          ));
                    },
                    itemCount: widget.item.data.length),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
