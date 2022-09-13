import 'package:decapet/helpers/transition.dart';
import 'package:decapet/models/dto/favorite_hospital_dto.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/pages/hospital/hospital_detail_header.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h18.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/components/custom_button_1.dart';
import 'package:decapet/pages/components/simple_header.dart';
import '../items/favorite_hosipital_item.dart';

class FavorHospitalPage extends StatefulWidget {
  const FavorHospitalPage({Key? key}) : super(key: key);

  @override
  FavorHospitalPageState createState() => FavorHospitalPageState();
}

class FavorHospitalPageState extends BaseState<FavorHospitalPage> {
  List<HospitalDto> favoriteHospitalList = [];
  ScrollController controller = ScrollController();

  bool isLast = false;
  int page = 0;

  @override
  void initState() {
    controller = ScrollController()..addListener(onScroll);
    super.initState();

    loadFavoriteHospitalList();
  }

  Future<bool> onBackPressed() async {
    hideKeyboard();
    Navigator.of(context).pop();
    return true;
  }

  void onScroll() {
    if (!isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadFavoriteHospitalList();
      }
    }
  }

  void goHospitalDetail(index) {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => HospitalDetailHeader(item: favoriteHospitalList[index])));
  }

  void removeFavorite(index) {
    showLoading();
    try {
      api
          .setFavorite(
              user.info.access_token, favoriteHospitalList[index].id, "n")
          .then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            favoriteHospitalList.removeAt(index);
          });
        } else {
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  Future<void> refresh() async {
    page = 0;
    loadFavoriteHospitalList();
  }

  void loadFavoriteHospitalList() {
    showLoading();
    try {
      api.favoriteHospitalList(user.info.access_token, page).then((res) {
        if (res.result == 0) {
          hideLoading();
          if (page == 0) {
            favoriteHospitalList.clear();
          }
          setState(() {
            favoriteHospitalList.addAll(res.data!.list);
            isLast = res.data!.isLast;
          });
        } else {
          hideLoading();
          showToast(res.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        isLoading: isLoading,
        child: Column(
          children: [
            SimpleHeader(
              title: LanguageService.trans('favorite_hospital'),
              onBackPressed: onBackPressed,
            ),
            Expanded(
              //child: Container(
              //height: double.infinity,
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    return FavoriteHospitalItem(
                      item: favoriteHospitalList[index],
                      onSelect: () {
                        goHospitalDetail(index);
                      },
                      onFavorite: () {
                        removeFavorite(index);
                      },
                    );
                  },
                  itemCount: favoriteHospitalList.length,
                ),
              ),
            ),
            //),
          ],
        ));
  }
}
