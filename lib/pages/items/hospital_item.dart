import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class HospitalItemData {
  int id;
  bool isSelected = false;
  HospitalDto data;

  HospitalItemData({
    required this.id,
    required this.isSelected,
    required this.data,
  });
}

class HospitalItem extends StatefulWidget {
  HospitalItemData item;

  HospitalItem({required this.item, required this.onSelect});

  final void Function(int selectedIndex) onSelect;

  @override
  HospitalItemState createState() => HospitalItemState();
}

class HospitalItemState extends BaseState<HospitalItem> {
  bool showDetail = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {}

  void toggleDetail() {
    setState(() {
      showDetail = true;
      widget.item.isSelected = true;
      widget.onSelect(widget.item.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleDetail,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 350,
            decoration: BoxDecoration(border: Border.all(color: widget.item.isSelected ? AppColor_Primary : AppColor_Gray), borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExtendedImage(
                      image: NetworkImage(widget.item.data.image),
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  H16(
                    text: "[" + getGuName(widget.item.data.address) + "] " + widget.item.data.name,
                    weight: FW.bold,
                    height: 1.1,
                    align: TextAlign.left,
                  ),
                  Image.asset(widget.item.data.like_yn == "y" ? "assets/ic_like_on.png" : "assets/ic_like_off.png", width: 15, height: 15),
                ]),
                const SizedBox(height: 10),
                H14(
                  text: widget.item.data.address,
                  weight: FW.medium,
                ),
                const SizedBox(height: 20),
                Row(children: [
                  Image.asset('assets/ic_star.png', width: 12),
                  const SizedBox(width: 5),
                  // H14(
                  //     text: widget.item.data.likepoint.toString(),
                  //     weight: FW.medium,
                  //     height: 1.1),
                  H14(text: widget.item.data.like_cnt.toString(), weight: FW.medium, height: 1.1),
                ]),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
