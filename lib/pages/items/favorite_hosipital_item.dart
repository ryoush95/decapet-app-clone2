import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/models/dto/favorite_hospital_dto.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h12.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/hospital/favor_hospital.dart';
import 'package:decapet/pages/hospital/hospital_detail.dart';
import 'package:decapet/pages/hospital/hospital_detail_header.dart';
import 'package:decapet/pages/hospital/hospital_info.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';
import '../components/h14.dart';

class FavoriteHospitalItem extends StatelessWidget {
  final HospitalDto item;
  final onSelect;
  final onFavorite;

  FavoriteHospitalItem(
      {Key? key, required this.item, this.onSelect, this.onFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor_Gray)
      ),
      child: InkWell(
        onTap: onSelect,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExtendedImage(
                  image: NetworkImage(item.image),
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                H14(
                  text: "[" + getGuName(item.address) + "] " + item.name,
                  weight: FW.medium,
                  align: TextAlign.left,
                ),
                InkWell(
                  onTap: onFavorite,
                  child: Image.asset("assets/ic_like_on.png",
                      width: 24, height: 24),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            H12(
              text: LanguageService.trans(item.address_detail),
              weight: FW.medium,
              align: TextAlign.left,
              color: AppColor_BlackText,
            ),
          ],
        ),
      ),
    );
  }
}
