//user level
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/app_info1_dto.dart';
import 'package:decapet/models/dto/drug_dto.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:intl/intl.dart';

String CUSTOMER_CENTER = "admin@kyadmeeting.com";
String APP_INSTALL_URL = "https://digcard.page.link/install";
// const String API_BASE_URL = "http://192.168.0.29:8009/"; //py server
// const String API_BASE_URL = "http://192.168.0.22:8206/"; //yj server
const String API_BASE_URL = "http://decapet.com:3000/"; //real server
const String TERMS_ULR = "http://decapet.com/terms"; //
const String POLICY_ULR = "http://decapet.com/privacy"; //
const String REDIRECT_URL = "http://decapet.com:3000/api/Pay/complete";
const String PRODUCT_URL = "http://decapet.com/terms-caution";

String gPushKey = "";
String gLangCode = "en";
String tempPhone = "";
String tempId = "";
String tempEmail = "";
String isSick = "y";
late AppInfo1Dto gStartInfo;
List<DrugItemDto> gDrugList = [];

enum ResultStatus { success, error }

enum MainTab { home, review_write, find_hospital, my_page }

enum PhoneAuthType { login, signup, changePhone }

DateFormat dateFormat = DateFormat('yyyy-MM-dd');
DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

double myLocLati = 0.0;
double myLocLng = 0.0;

class Feeling {
  String type;
  String image;
  String feeling;

  Feeling({
    this.type = "",
    this.image = "",
    this.feeling = "",
  });
}

String getGuName(String address) {
  String gu = "", gu2 = "";
  if (address.split(' ').length > 2) {
    gu = address.split(' ')[1];
    gu2 = address.split(' ')[2];
    if (gu.contains(LanguageService.trans('gu'), gu.length - 2)) {
      return gu;
    } else if (gu2.contains(LanguageService.trans('gu'), gu2.length - 2)) {
      return gu2;
    } else {
      return "";
    }
  } else {
    return address;
  }
}

String getDDay1(String date) {
  String result = "";

  if (date == "") {
    return result;
  }

  DateTime tempDate = DateTime.parse(date);
  int diffDays = DateTime.now().difference(tempDate).inDays;
  result = "D-" + (365 - diffDays.abs()).toString();
  return result;
}

int getDDay1Pcercent(PetDto info) {
  int result = 0;

  if (info.rabies_created_at == "") {
    return result;
  }
  // int allDays = DateTime.parse(info.rabies_created_at).difference(DateTime.parse(info.rabies_dt)).inDays;
  // allDays = allDays.abs();

  DateTime tempDate = DateTime.parse(info.rabies_dt);
  int diffDays = DateTime.now().difference(tempDate).inDays;
  diffDays = diffDays.abs();
  result = diffDays * 100 ~/ 365;
  return result;
}

String getDDay2(String date, int drugId) {
  String result = "";

  if (date == "" || gDrugList.isEmpty) {
    return result;
  }
  int durg_duration = 0;
  for (var i = 0; i < gDrugList.length; i++) {
    if (gDrugList.elementAt(i).id == drugId.toString()) {
      durg_duration = int.parse(gDrugList.elementAt(i).period.isEmpty ? "1" : gDrugList.elementAt(i).period) * 30;
    }
  }

  DateTime tempDate = DateTime.parse(date);
  int diffDays = tempDate.difference(DateTime.now()).inDays;

  if (diffDays > 0) {
    result = "D-" + (diffDays.abs() % durg_duration).toString();
  } else {
    result = "D-" + ((durg_duration - diffDays.abs()) % durg_duration).toString();
  }

  return result;
}

int getDDay2Pcercent(String date, int drugId) {
  int result = 0;

  if (date == "" || gDrugList.isEmpty) {
    return result;
  }
  int durg_duration = 0;
  for (var i = 0; i < gDrugList.length; i++) {
    if (gDrugList.elementAt(i).id == drugId.toString()) {
      durg_duration = int.parse(gDrugList.elementAt(i).period.isEmpty ? "1" : gDrugList.elementAt(i).period) * 30;
    }
  }

  DateTime tempDate = DateTime.parse(date);
  int diffDays = tempDate.difference(DateTime.now()).inDays;

  if (diffDays > 0) {
    result = ((durg_duration - diffDays.abs()) % durg_duration) * 100 ~/ durg_duration;
  } else {
    result = (diffDays.abs() % durg_duration) * 100 ~/ durg_duration;
  }

  return result;
}

String makeStr(String str) {
  String result = "";

  if (str == "") {
    return result;
  }

  if (str.length == 1 || str.length == 2) {
    return str;
  }

  result = str.substring(0, 2);
  for (var i = 0; i < str.length - 2; i++) {
    result = result + "*";
  }
  return result;
}
