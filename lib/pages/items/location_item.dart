import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:flutter/src/painting/edge_insets.dart';

class LocationItem extends StatelessWidget {
  final String title;
  String icon_path;
  double font_size;
  FW font_style;
  final String badge;

  LocationItem({
    Key? key,
    required this.title,
    required this.icon_path,
    required this.font_size,
    required this.font_style,
    required this.badge
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color color_val = AppColor_BlackText;// as int;

    return Container(

      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            //fit: FlexFit.tight,
            margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Image.asset(
                icon_path,
                width: 25, height: 25, alignment: Alignment.center),
          ),

          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: InkWell(
                //onTap: onLogout,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.PD(AppColor_BlackText, font_size, weight: font_style, height: 1.0),
                    textAlign: TextAlign.start,
                  )
              )
          ),

          Container(
              child: badge!=""?Container()
              /*Badge(
                  content: badge,
                  font_size: font_size,
                  font_style: font_style
              )*/:
              Container()
          )
        ],
      ),
    );
  }
}
