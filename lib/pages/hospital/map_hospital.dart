import 'dart:io';

import 'package:decapet/global/global.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/hospital/hospital_reserve_dialog.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MapHospitalPage extends StatefulWidget {
  MapHospitalPage({Key? key, required this.hospitalList}) : super(key: key);

  List<HospitalDto> hospitalList = [];
  @override
  MapHospitalPageState createState() => MapHospitalPageState();
}

class MapHospitalPageState extends BaseState<MapHospitalPage> {
  MapCreateCallback? mapCreateCallback;
  late CameraPosition initialCameraPosition;
  List<Marker> markers = [];

  bool isLast = false;
  int page = 0;

  @override
  void initState() {
    super.initState();

    initialCameraPosition = CameraPosition(target: LatLng(myLocLati, myLocLng));
  }

  Future<bool> onBackPressed() async {
    hideKeyboard();
    Navigator.of(context).pop();
    return true;
  }

  Future<void> initData() async {
    //current location
    String iconImage = Platform.isIOS ? "assets/ic_my_loc1.png" : "assets/ic_my_loc.png";
    markers.add(Marker(
        markerId: "0",
        position: LatLng(myLocLati, myLocLng),
        icon: await OverlayImage.fromAssetImage(assetName: Platform.isIOS ? "assets/ic_my_loc1.png" : "assets/ic_my_loc.png", context: context),
        // icon: await OverlayImage.fromAssetImage(iconImage, context),
        onMarkerTab: (marker, iconSize) {
          //showToast(marker!.markerId);
        }));

    if (widget.hospitalList.isNotEmpty) {
      for (int i = 0; i < widget.hospitalList.length; i++) {
        HospitalDto info = widget.hospitalList.elementAt(i);
        String imgName = "";
        if (Platform.isIOS) {
          imgName = info.reserve_yn == "y" ? "assets/ic_reserve1_1.png" : "assets/ic_reserve2_1.png";
        } else {
          imgName = info.reserve_yn == "y" ? "assets/ic_reserve1.png" : "assets/ic_reserve2.png";
        }

        markers.add(Marker(
            markerId: (i + 1).toString(),
            position: LatLng(info.latitude, info.longitude),
            captionText: info.name,
            icon: await OverlayImage.fromAssetImage(assetName: imgName, context: context),
            captionTextSize: 15,
            onMarkerTab: (marker, iconSize) {
              onReserve(info);
            }));
      }
    }
    setState(() {});
  }

  void onReserve(HospitalDto item) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return HospitalReserveDialog(item: item);
        });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        isLoading: isLoading,
        child: Column(
          children: [
            SimpleHeader(
              title: LanguageService.trans('view_map'),
              onBackPressed: onBackPressed,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(24),
                child: NaverMap(
                  onMapCreated: (value) {
                    initData();
                  },
                  onMapTap: (value) {
                    // showToast(value.latitude.toString() + ", " + value.longitude.toString());
                  },
                  initialCameraPosition: initialCameraPosition,
                  markers: markers,
                  rotationGestureEnable: false,
                ),
              ),
            ),
            //),
          ],
        ));
  }
}
