import 'dart:async';
import 'dart:convert';

import 'package:decapet/models/dto/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static String PREF_USER = "PREF_USER";
  static String PREF_REViEW_GUIDE = "PREF_REViEW_GUIDE";
  static String PREF_FCM_TOKEN = "PREF_FCM_TOKEN";

  static void setUser(UserDto userDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_USER, json.encode(userDto.toJson()));
  }

  static void removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PREF_USER);
  }

  static Future<UserDto?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString(PREF_USER);
    if (user == null || user.isEmpty) {
      return null;
    }
    return UserDto.fromJson(json.decode(user));
  }

  static void setShowReviewGuide(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PREF_REViEW_GUIDE, val);
  }

  static Future<int> getShowReviewGuide() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? val = prefs.getInt(PREF_REViEW_GUIDE);
    val ??= 0;
    return val;
  }

  static void setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_FCM_TOKEN, value);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(PREF_FCM_TOKEN);
    if (token == null || token.isEmpty) {
      return "";
    }
    return token;
  }
}
