// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:decapet/global/global.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

void showToast(String msg) {
  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 14.0);
}

String enumToString(value) {
  return value.toString().split('.').last;
}

String formatAmount(int num) {
  NumberFormat format = new NumberFormat("#,###");
  return format.format(num);
}

double doubleParse(dynamic val) {
  if (val == null) return 0;

  if (val.runtimeType == double) {
    return val;
  }

  return double.parse(val);
}

Future<String> getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

bool keyboardIsVisible(BuildContext context) {
  return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
}

Future<String> getShareUrl(int _uid) async {
  var result = "";

  // Todo yj
  /*
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://semari.page.link',
    link: Uri.parse('https://semari.com/detail?id=' + _uid.toString()),
    androidParameters: AndroidParameters(
      packageName: 'com.kyad.semari',
      minimumVersion: 1,
    ),
    dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
    ),
    iosParameters: IosParameters(
      bundleId: 'com.kyad.semari',
      minimumVersion: '1.0.0',
      appStoreId: '1597695150',
    ),
  );

  final ShortDynamicLink shortLink = await parameters.buildShortLink();
  Uri url = shortLink.shortUrl;
  result = url.toString();
   */
  return result;
}

bool validPwd(String pwd) {
  String pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(pwd);
}

bool validPhone(String phone) {
  String pattern = r"^01(?:0|1|[6-9])[-\\s\\.]?[0-9]{4}[-\\s\\.]?[0-9]{4}$";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(phone);
}

int calDateInterval(String date) {
  int interval = 0;
  DateTime now = DateTime.now();
  DateTime current = dateFormat.parse(date);
  Duration duration = current.difference(now);
  interval = duration.inDays;
  return interval;
}

String convertNumber(String data) {
  double num = double.parse(data);
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  String s = num.toString().replaceAll(regex, '');
  return s;
}
