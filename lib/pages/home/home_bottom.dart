import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h20.dart';
import 'package:decapet/pages/items/homebottom_item.dart';
import 'package:decapet/pages/review/review_manage.dart';
import 'package:flutter/material.dart';

class HomeBottomPage extends StatefulWidget {
  HomeBottomPage({Key? key}) : super(key: key);

  @override
  HomeBottomPageState createState() => HomeBottomPageState();
}

class HomeBottomPageState extends BaseState<HomeBottomPage> {
  @override
  void initState() {
    super.initState();
    loadHomeBottom();

    event.on<ReviewDeleted>().listen((event) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].id == event.reviewUid) {
          setState(() {
            items.removeAt(i);
          });
        }
      }
    });

    event.on<ReviewUpdated>().listen((event) {
      if (mounted) {
        if (event.reviewUid == 0) {
          loadHomeBottom();
        } else {
          for (int i = 0; i < items.length; i++) {
            if (items[i].id == event.reviewUid) {
              setState(() {
                items[i] = event.review;
              });
            }
          }
        }
      }
    });

    event.on<LikeHospital>().listen((event) {
      if (mounted) {
        for (int index = 0; index < items.length; index++) {
          if (items[index].hospital_id == event.hospitalUid) {
            setState(() {
              items[index].favourite_yn == event.likeYn;
            });
          }
        }
      }
    });
  }

  List<ReviewDto> items = [];

  void loadHomeBottom() {
    showLoading();
    try {
      api.recent_review_list(user.info.access_token).then((res) {
        if (res.result == 0) {
          hideLoading();
          items = res.data!.list;
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

  void onLikeReview(index) {
    if (items[index].user_id == user.info.id) {
      return;
    }

    String likeYn = items[index].like_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.likeReview(user.info.access_token, items[index].id, likeYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            items[index].like_yn = likeYn;
            if (likeYn == "y") {
              items[index].like_cnt = items[index].like_cnt + 1;
            } else {
              items[index].like_cnt = items[index].like_cnt - 1;
            }
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

  void onGoReviewManage() {
    Navigator.push(context, SlideRightTransRoute(builder: (context) => ReviewManagePage(type: 'all')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: H20(
                    text: LanguageService.trans("home_bottom_description"),
                    align: TextAlign.left,
                  ),
                ),
                InkWell(
                  child: H14(
                    text: LanguageService.trans("more"),
                    align: TextAlign.right,
                    color: AppColor_Gray,
                  ),
                  onTap: onGoReviewManage,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return HomeBottomItem(
                    item: items[index],
                    onLikeReview: () {
                      onLikeReview(index);
                    },
                  );
                },
                itemCount: items.length),
          ),
        ],
      ),
    );
  }
}
