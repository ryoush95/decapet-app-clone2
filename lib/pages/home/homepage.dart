import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/date_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/home/pet_item.dart';
import 'package:decapet/pages/home/widget_reg_pet.dart';
import 'package:flutter/material.dart';

import 'home_bottom.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BaseState<HomePage> {
  List<PetDto> petList = [];
  String intentGuide = "";
  String guide = "";
  ScrollController scrollController = ScrollController();

  bool isLast = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(loadMore);
    getDrugList();
    loadIntentGuide();

    event.on<ChangeInoculation>().listen((event) {
      if (mounted) {
        for (int i = 0; i < petList.length; i++) {
          if (petList[i].id == event.petUid) {
            if (event.type == "rabies") {
              setState(() {
                petList[i].rabies_dt = event.date;
                petList[i].rabies_dd = getDayDiff(petList[i].rabies_dt);
              });
            } else if (event.type == "heartworm") {
              setState(() {
                petList[i].heartworm_dt = event.date;
                petList[i].heartworm_dd = getDayDiff(petList[i].heartworm_dt);
                petList[i].heartworm_drug_id = event.drugUid;
                petList[i].heartworm_drug_name = event.drugName;
              });
            } else {
              setState(() {
                petList[i].ecto_dt = event.date;
                petList[i].ecto_dd = getDayDiff(petList[i].heartworm_dt);
                petList[i].ecto_drug_id = event.drugUid;
                petList[i].ecto_drug_name = event.drugName;
              });
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(loadMore);
    super.dispose();
  }

  void loadMore() {
    if (!isLoading) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadPetList();
      }
    }
  }

  void loadIntentGuide() {
    showLoading();
    try {
      api.intent_guide(user.info.access_token, "home").then((value) {
        hideLoading();
        if (value.result == 0) {
          setState(() {
            intentGuide = value.data!;
          });
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void getDrugList() {
    showLoading();
    try {
      api.drug_list1(user.info.access_token, "", "", 0).then((value) {
        hideLoading();
        if (value.result == 0) {
          gDrugList = value.data!.list;
          loadPetList();
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  void loadPetList() {
    showLoading();
    try {
      api.pet_list(user.info.access_token).then((value) {
        hideLoading();
        if (value.result == 0) {
          petList.clear();
          for (PetDto item in value.data!.list) {
            petList.add(item);
          }
          guide = value.data!.guide;
          isLast = value.data!.isLast;
        } else {
          showToast(value.msg!);
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildPetList(),
            const SizedBox(height: 20),
            HomeBottomPage(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H20(
                text: getDateFormatString(DateTime.now(), "MMMMEEEEd"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  H20(
                    align: TextAlign.left,
                    weight: FW.medium,
                    text: LanguageService.trans('home_header_description'),
                  ),
                  Image.asset(
                    "assets/smile.png",
                    width: 25,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          // height: 50,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.transparent), borderRadius: BorderRadius.circular(0), color: AppColor_Primary),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: H16(
              align: TextAlign.left,
              height: 1.5,
              weight: FW.medium,
              color: Colors.white,
              text: intentGuide,
              maxLine: 5,
            ),
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const SizedBox(width: 30),
          //     H16(align: TextAlign.left, weight: FW.medium, color: Colors.white, text: intentGuide + intentGuide, maxLine: 5),
          //     // Expanded(child: Container()),
          //     // Image.asset(
          //     //   "assets/ic_right.png",
          //     //   width: 8,
          //     //   color: Colors.white,
          //     // ),
          //     const SizedBox(width: 30),
          //   ],
          // ),
        )
      ],
    );
  }

  Widget _buildPetList() {
    return Container(
      height: 550,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (index == petList.length) {
              return WidgetRegPet();
            } else {
              return PetItem(
                item: petList[index],
                guide: guide,
              );
            }
          },
          itemCount: petList.length + 1),
    );
  }
}
