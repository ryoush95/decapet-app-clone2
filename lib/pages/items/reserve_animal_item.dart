import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/H26.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/material.dart';

class ReserveAnimalItem extends StatefulWidget {
  final PetDto item;
  final isSelected;
  final void Function() onSelect;

  ReserveAnimalItem({Key? key, required this.item, required this.onSelect, required this.isSelected}) : super(key: key);

  @override
  ReserveAnimalItemState createState() => ReserveAnimalItemState();
}

class ReserveAnimalItemState extends BaseState<ReserveAnimalItem> {
  String level = "";
  String levelImage = "";

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          height: 200,
          decoration: BoxDecoration(
            color: AppColor_White,
            border: widget.isSelected ? Border.all(color: AppColor_Primary, width: 1.0) : Border.all(color: AppColor_White, width: 1.0),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColor_Gray,
                blurRadius: 5.0, // soften the shadow
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(widget.item.animal_type == "cat" ? 'assets/ic_cat.png' : 'assets/ic_dog.png', width: 25, height: 25),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        LanguageService.trans('unique_number') + widget.item.registration_number,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.PD(AppColor_GrayText, 12, weight: FW.regular),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Center(
                      child: Image.asset(widget.item.animal_type == "cat" ? 'assets/ic_default_cat.png' : 'assets/ic_default_dog.png', width: 60, height: 60),
                    ),
                  ),
                  const SizedBox(width: 35),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        H26(
                          text: level,
                          weight: FW.medium,
                          align: TextAlign.center,
                          color: AppColor_Table_DateTime,
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
                          color: AppColor_Table_DateTime,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.only(top: 7),
                    child: Image.asset(levelImage, width: 30, height: 30),
                  )
                ],
              ),
            ],
          )),
      onTap: widget.onSelect,
    );
  }
}
