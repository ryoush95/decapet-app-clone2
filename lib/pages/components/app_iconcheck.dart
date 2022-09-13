import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';

import 'h14.dart';
import 'h16.dart';

class AppIconCheckbox extends StatefulWidget {
  final padding;
  AppIconCheckbox(
      {Key? key,
      required this.text,
      required this.checked,
      required this.onChecked,
      this.padding,
      this.withBorder = false})
      : super(key: key);

  String text;
  bool checked = false;
  final void Function(bool? checked) onChecked;
  bool withBorder = false;

  @override
  AppIconCheckboxState createState() => AppIconCheckboxState();
}

class AppIconCheckboxState extends State<AppIconCheckbox> {

  bool checkStatus = false;

  @override
  void initState() {
    super.initState();
    checkStatus = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.withBorder) {
      return InkWell(
        child: Container(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: checkStatus? AppColor_Primary: AppColor_Selector_Border)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                    checkStatus
                        ? 'assets/icon_check_on.png'
                        : 'assets/icon_check_off.png',
                    height: 22),
                const SizedBox(width: 8),
                H16(text: widget.text, weight: FW.medium)
              ],
            ),
          )
        ),
        onTap: () {
          setState(() {
            checkStatus = !checkStatus;
          });
          widget.onChecked(checkStatus);
        },
      );
    } else {
      return InkWell(
        child: Row(
          children: [
            Image.asset(
                checkStatus
                    ? 'assets/icon_check_on.png'
                    : 'assets/icon_check_off.png',
                height: 22),
            const SizedBox(width: 8),
            H14(text: widget.text, weight: FW.medium)
          ],
        ),
        onTap: () {
          setState(() {
            checkStatus = !checkStatus;
          });
          widget.onChecked(checkStatus);
        },
      );
    }
  }
}
