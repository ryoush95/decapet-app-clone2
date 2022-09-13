import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:flutter/material.dart';

class AlarmDetailPage extends StatefulWidget {
  const AlarmDetailPage({Key? key, required this.title, required this.time, required this.content}) : super(key: key);
  final String title;
  final String time;
  final String content;

  @override
  AlarmDetailPageState createState() => AlarmDetailPageState();
}

class AlarmDetailPageState extends BaseState<AlarmDetailPage> {
  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  @override
  void initState() {
    super.initState();

    // title = "[Notice] Decaf has been updated to v.1.2.2.!";
    // time = "2022.02.18 15:00";
    // content = "Hello, this, ...\n\n\n\n\n\n\n\n\n\n\n\nNext line";
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans('Alarm'),
            onBackPressed: onBackPressed,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                // title
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: H16(
                    align: TextAlign.left,
                    text: widget.title,
                    weight: FW.bold,
                    height: 1.1,
                  ),
                ),

                const SizedBox(height: 14),
                // time
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: H14(
                    text: widget.time,
                    weight: FW.medium,
                    align: TextAlign.left,
                    color: AppColor_Table_DateTime,
                  ),
                ),

                const SizedBox(height: 24),
                // content
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: H14(
                    text: widget.content,
                    weight: FW.regular,
                    align: TextAlign.left,
                    maxLine: 2000,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
