import 'package:decapet/pages/auth/passwd_complete_fragment.dart';
import 'package:decapet/pages/auth/registered_fragment.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_colors.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/h24_b.dart';
import 'package:decapet/pages/auth/findid_fragment.dart';
import 'package:decapet/pages/auth/findpasswd_fragment.dart';

import 'certification_id_fragment.dart';
import 'certification_passwd_fragment.dart';
import 'new_passwd_fragment.dart';

class FindFragment extends StatefulWidget {
  final int type; // 0 : id, 1: password

  FindFragment({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  FindFragmentState createState() => FindFragmentState();
}

class FindFragmentState extends BaseState<FindFragment>
    with TickerProviderStateMixin {
  int tabIndex = 0;
  int isSendCode = 0;
  int isPassCode = 0;
  int code = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      changeTab(tabController.index);
    });

    tabController.index = widget.type;
  }

  void onSendCode(int code) {
    setState(() {
      this.code = code;
      isSendCode = code;
    });
  }

  void onPassCode(int code) {
    setState(() {
      this.code = code;
      isPassCode = code;
    });
  }

  Future<bool> onBackPressed() async {
    if (isSendCode>=1) {
      setState(() {
        isSendCode = isSendCode - 1;
      });
      //return true;
    }
    if (isPassCode>=1) {
      setState(() {
        isPassCode = isPassCode - 1;
      });
      //return true;
    }
    Navigator.of(context).pop();
    return false;
  }

  void changeTab(int tab) {
    setState(() {
      tabIndex = tab;
      tabController.index = tabIndex;
      isSendCode = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      isAvoidResize: true,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 60,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      child: Container(
                          child:
                          Image.asset('assets/btn_back.png', width: 10)),
                      onTap: onBackPressed,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTabHeaderItem(LanguageService.trans("find_id"), 0),
                _buildTabHeaderItem(LanguageService.trans("find_passwd"), 1),
              ],
            ),
          ),
          Expanded(
              child: DefaultTabController(
                length: 1,
                child: Scaffold(
                    body: TabBarView(
                      controller: tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Stack(
                          children: [
                            Visibility(
                              visible: (isSendCode==1)?true:false,
                              child: CertificationIdFragment(onSendCode: onSendCode,),
                            ),
                            Visibility(
                              visible: (isSendCode==0)?true:false,
                              child: FindIdFragment(onSendCode: onSendCode,),
                            ),
                            Visibility(
                              visible: (isSendCode==2)?true:false,
                              child: RegisteredFragment(),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Visibility(
                              visible: (isPassCode==1)?true:false,
                              child: CertificationPasswdFragment(onSendCode: onPassCode,),
                            ),
                            Visibility(
                              visible: (isPassCode==0)?true:false,
                              child: FindPasswdFragment(onSendCode: onPassCode,),
                            ),
                            Visibility(
                              visible: (isPassCode==2)?true:false,
                              child: NewPasswdFragment(onSendCode: onPassCode,),
                            ),
                            Visibility(
                              visible: (isPassCode==3)?true:false,
                              child: PasswordCompleteFragment(),
                            ),

                          ],
                        ),
                      ],
                    )),
              ))
        ])
      ),
    );
  }

  Widget _buildTabHeaderItem(String tabText, int step) {
    return InkWell(
      child: Stack(
        children: [
          SizedBox(
              width: (MediaQuery.of(context).size.width - 70) / 2,
              height: 35,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: tabIndex == step
                        ? H24B(
                            text: tabText,
                            color: AppColor_Primary,
                          )
                        : H24B(
                            text: tabText,
                            color: AppColor_Tab_Unselected,
                          ),
                  ),
                ],
              )),
        ],
      ),
      onTap: () {
        changeTab(step);
      },
    );
  }
}
