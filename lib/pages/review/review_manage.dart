import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/app_event.dart';
import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/custom_button_3.dart';
import 'package:decapet/pages/components/custom_button_4.dart';
import 'package:decapet/pages/components/custom_button_5.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:decapet/pages/home/write_receipt_review.dart';
import 'package:decapet/pages/items/review_item.dart';
import 'package:flutter/material.dart';

class ReviewManagePage extends StatefulWidget {
  String? type;
  ReviewManagePage({Key? key, this.type = ''}) : super(key: key);

  @override
  ReviewManagePageState createState() => ReviewManagePageState();
}

class ReviewManagePageState extends BaseState<ReviewManagePage> {
  List<ReviewDto> reviewList = [];
  ScrollController controller = ScrollController();

  bool isLast = false;
  int page = 0;

  @override
  void initState() {
    super.initState();

    event.on<ReviewUpdated>().listen((event) {
      if (mounted) {
        if (event.reviewUid == 0) {
          page = 0;
          loadReviewList();
        } else {
          for (int i = 0; i < reviewList.length; i++) {
            if (reviewList[i].id == event.reviewUid) {
              setState(() {
                reviewList[i] = event.review;
              });
            }
          }
        }
      }
    });

    event.on<LikeHospital>().listen((event) {
      if (mounted) {
        for (int index = 0; index < reviewList.length; index++) {
          if (reviewList[index].hospital_id == event.hospitalUid) {
            setState(() {
              reviewList[index].favourite_yn == event.likeYn;
            });
          }
        }
      }
    });

    loadReviewList();
  }

  void onScroll() {
    if (!isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (isLast) {
          return;
        }
        page = page + 1;
        loadReviewList();
      }
    }
  }

  void loadReviewList() {
    showLoading();
    int userId = user.info.id;
    if (widget.type == 'all') {
      userId = 0;
    }
    try {
      api.review_list(user.info.access_token, page, 0, "", "", "recent", userId).then((res) {
        if (res.result == 0) {
          hideLoading();
          if (page == 0) {
            reviewList.clear();
          }
          setState(() {
            reviewList.addAll(res.data!.list);
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

  Future<bool> onBackPressed() async {
    if (keyboardIsVisible(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    Navigator.of(context).pop();
    return true;
  }

  Future<void> refresh() async {
    page = 0;
    loadReviewList();
  }

  void onLikeHospital(index) {
    String favoriteYn = reviewList[index].favourite_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.setFavorite(user.info.access_token, reviewList[index].hospital_id, favoriteYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            reviewList[index].favourite_yn = favoriteYn;
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

  void onLikeReview(index) {
    if (reviewList[index].user_id == user.info.id) {
      return;
    }

    String likeYn = reviewList[index].like_yn == "y" ? "n" : "y";
    showLoading();
    try {
      api.likeReview(user.info.access_token, reviewList[index].id, likeYn).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            reviewList[index].like_yn = likeYn;
            if (likeYn == "y") {
              reviewList[index].like_cnt = reviewList[index].like_cnt + 1;
            } else {
              reviewList[index].like_cnt = reviewList[index].like_cnt - 1;
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

  void onMore(index) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)), color: Colors.transparent),
          child: Column(
            children: [
              CustomButton3(
                onPressed: () {
                  Navigator.of(context).pop();
                  onEdit(index);
                },
                text: LanguageService.trans('to_edit'),
                fontcolor: Colors.blue,
              ),
              Container(
                height: 1,
                color: AppColor_Gray,
              ),
              CustomButton4(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDelete(index);
                },
                text: LanguageService.trans('delete'),
                fontcolor: Colors.red,
              ),
              const SizedBox(height: 5),
              CustomButton5(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: LanguageService.trans('cancel'),
                fontcolor: Colors.blue,
              )
            ],
          ),
        );
      },
    );
  }

  void onEdit(index) {
    Navigator.push(
        context,
        SlideRightTransRoute(
            builder: (context) => WriteReceiptReviewPage(
                  medicalUid: reviewList[index].medical_record_id,
                  hospitalName: reviewList[index].hospital_name,
                  hospitalUid: reviewList[index].hospital_id,
                  reviewId: reviewList[index].id,
                )));
  }

  void onDelete(index) {
    showLoading();
    try {
      api.review_delete(user.info.access_token, reviewList[index].id).then((res) {
        hideLoading();
        if (res.result == 0) {
          setState(() {
            reviewList.removeAt(index);
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

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: Column(
        children: [
          SimpleHeader(
            title: LanguageService.trans('mypage_reviewmanagement'),
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: Container(
              color: AppColor_Light_Gray,
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    return ReviewItem(
                      item: reviewList[index],
                      onMore: () {
                        onMore(index);
                      },
                      onLikeHospital: () {
                        onLikeHospital(index);
                      },
                      onLikeReview: () {
                        onLikeReview(index);
                      },
                    );
                  },
                  itemCount: reviewList.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
