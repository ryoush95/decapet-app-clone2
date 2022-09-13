import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h16.dart';

// for test

class RadioItemData {
  int item_id;
  String item_name;
  bool item_selected;

  RadioItemData({
    required this.item_id,
    required this.item_name,
    required this.item_selected,
  });
}
