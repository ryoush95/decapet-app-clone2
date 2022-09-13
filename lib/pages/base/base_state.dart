import 'package:decapet/global/app_api.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/widgets.dart';
import 'package:decapet/global/app_get_it.dart';
import 'package:decapet/stores/user_info_store.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  final Api api = getIt<Api>();
  bool isLoading = false;
  final user = getIt<UserInfoStore>();
  final event = getIt<EventBus>();
  final List<Feeling> feelingList = [];
  List<String> feelings = [];

  void showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void hideKeyboard() {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
