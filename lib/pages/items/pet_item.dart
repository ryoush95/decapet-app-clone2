import 'package:decapet/models/dto/petitem_dto.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import '../components/h14.dart';

class PetItem extends StatelessWidget {
  final PetItemDto item;
  Color? bordercolor;
  String? name;
  String? content;

  PetItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 30),
      //padding: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.fromLTRB(47, 6, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 300,
            //color: Colors.green,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: bordercolor!,),
              color: Colors.transparent,
            ),
            child:Row(
              children: [
                SizedBox(width: 5,),
                H14(
                  text: LanguageService.trans(item.name),
                  weight: FW.medium,
                  align: TextAlign.left,
                  color: bordercolor!,
                ),
                SizedBox(width: 100,),
                H14(
                  text: LanguageService.trans(item.content),
                  weight: FW.medium,
                  align: TextAlign.right,
                  color: AppColor_BlackText,
                ),
              ],
            ),
          ),
          //const SizedBox(height: 6,),
        ],
      ),
    );
  }
}
