import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/home/pet_item.dart';
import 'package:flutter/material.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({Key? key}) : super(key: key);

  @override
  PetListPageState createState() => PetListPageState();
}

class PetListPageState extends BaseState<PetListPage> {
  List<PetDto> petList = [];
  String guide = "";

  @override
  void initState() {
    super.initState();
    getPetList();
  }

  void getPetList() {
    showLoading();
    try {
      api.pet_list(user.info.access_token).then((value) {
        hideLoading();

        if (value.result == 0) {
          petList = value.data!.list;
          guide = value.data!.guide;
        } else {
          showToast(value.msg!);
        }
      });
    } on Exception catch (_, e) {
      hideLoading();
      showToast(LanguageService.trans("network_error"));
    }
  }

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  void onOther(String type) {}

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans("pet_list"),
            onBackPressed: onBackPressed,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: double.infinity,
                height: 550,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return PetItem(
                      item: petList[index],
                      guide: guide,
                    );
                  },
                  itemCount: petList.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
