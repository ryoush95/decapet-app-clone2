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

class FeelingItem extends StatefulWidget {
  final bool isChecked;
  final String feeling;
  final String image;
  final onClick;

  FeelingItem({
    Key? key,
    required this.isChecked,
    required this.feeling,
    required this.image,
    required this.onClick,
  }) : super(key: key);

  @override
  FeelingItemState createState() => FeelingItemState();
}

class FeelingItemState extends BaseState<FeelingItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: AppColor_Gray,
              blurRadius: 5.0, // soften the shadow
            ),
          ],
          color: widget.isChecked ? AppColor_Primary : AppColor_White,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(widget.image, width: 20),
            const SizedBox(width: 5),
            Flexible(
                flex: 1,
                child: Text(widget.feeling,
                    maxLines: 5,
                    style: AppTextStyle.PD(
                        widget.isChecked ? Colors.white : Colors.black, 16.0))),
          ],
        ),
      ),
    );
  }
}
