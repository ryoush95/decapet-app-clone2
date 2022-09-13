import 'package:decapet/pages/components/app_devider.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:flutter/src/painting/edge_insets.dart';
import 'package:decapet/pages/mypage/badge.dart';

class ListItem extends StatelessWidget {
  final String title;
  String icon_path;
  double font_size;
  FW font_style;
  final String badge;
  ListItem({
    Key? key,
    required this.title,
    required this.icon_path,
    required this.font_size,
    required this.font_style,
    required this.badge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color color_val = AppColor_BlackText;// as int;

    return Container(
      height: 65,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          const AppDivider(height: 1.0, color: AppColor_Divider),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //fit: FlexFit.tight,
                margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Image.asset(
                  icon_path,
                  width: 25, height: 25, alignment: Alignment.center, color: Colors.black,),
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
                  child: Visibility(
                      visible: badge != "",
                      child: Badge(
                          content: badge,
                          font_size: 12,
                          font_style: FW.regular
                      )
                  )
              )
            ],
          ),
        ],
      )
    );
  }
}
