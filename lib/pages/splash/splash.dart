import 'dart:io';

import 'package:decapet/global/global.dart';
import 'package:decapet/global/local_service.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/app_info1_dto.dart';
import 'package:decapet/models/dto/user_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/nanum_r16.dart';
import 'package:decapet/pages/intro/start.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../tab_main.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends BaseState<SplashPage> {
  late Map statuses;
  int backButtonTimestamp = 0;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      checkPermission();
    } else {
      //startApp();
      onStart();
    }
  }

  Future<bool> onBackPressed() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - backButtonTimestamp < 2000) {
      exit(0);
    } else {
      showToast(LanguageService.trans('press_twice_to_exit'));
    }
    backButtonTimestamp = now;
    return false;
  }

  void onStart() {
    showLoading();
    try {
      String target = "";
      if (Platform.isAndroid) {
        target = "android";
      } else {
        target = "ios";
      }
      api.appStartInfo(target).then((res) {
        if (res.result == 0) {
          hideLoading();
          gStartInfo = res.data!;
          ServiceDto info = ServiceDto();
          info.full_name = "전체";
          info.short_name = "전체";
          gStartInfo.hospital_services.insert(0, info);
          startApp();
        } else {
          hideLoading();
          startApp();
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void startApp() async {
    LocationPermission permission = await Geolocator.requestPermission();
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // myLocLati = position.latitude;
    // myLocLng = position.longitude;
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) => {
          myLocLati = value.latitude,
          myLocLng = value.longitude,
        });
    //for test
    // myLocLati = 37.74913611;
    // myLocLng = 128.8784972;

    UserDto? localUser = await LocalService.getUser();
    await Future.delayed(const Duration(seconds: 1));
    gPushKey = await LocalService.getToken();
    if (localUser == null) {
      Navigator.pushReplacement(context, SlideRightTransRoute(builder: (context) => StartPage()));
    } else {
      showLoading();
      try {
        String target = "";
        if (Platform.isAndroid) {
          target = "android";
        } else {
          target = "ios";
        }
        api.login(localUser.email, localUser.pwd, target, gPushKey, 'normal').then((resData) => {
              hideLoading(),
              if (resData.result == 0)
                {
                  resData.data!.pwd = localUser.pwd,
                  user.setInfo(resData.data),
                  Navigator.pushReplacement(
                    context,
                    SlideRightTransRoute(
                      builder: (context) => TabMainPage(),
                    ),
                  )
                }
              else
                {Navigator.pushReplacement(context, SlideRightTransRoute(builder: (context) => StartPage()))}
            });
      } on Exception catch (_, e) {
        hideLoading();
        showToast(LanguageService.trans("network_error"));
      }
    }
  }

  Future<void> checkPermission() async {
    Map statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
      Permission.photos,
    ].request();

    if (statuses[Permission.camera] == PermissionStatus.granted && statuses[Permission.photos] == PermissionStatus.granted && statuses[Permission.storage] == PermissionStatus.granted && statuses[Permission.location] == PermissionStatus.granted) {
      //startApp();
      onStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        isLoading: isLoading,
        child: Column(
          children: [
            const SizedBox(height: 200),
            Center(
              child: Image.asset('assets/ic_intro_logo.png', width: 120, height: 120),
            ),
            const SizedBox(height: 1),
            Center(
              child: Image.asset('assets/ic_intro_logo_text.png', width: 150, height: 80),
            ),
            const SizedBox(height: 1),
            Center(
              child: NanumR16(
                text: LanguageService.trans("splash_title"),
                height: 0.5,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 50)
          ],
        ));
  }
}
