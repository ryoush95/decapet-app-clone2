import 'package:decapet/global/app_event.dart';
import 'package:decapet/global/global.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/bloodtest/bloodtest_complete.dart';
import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class PaymentPage extends StatefulWidget {
  String? payMethod;
  String? merchantUid;
  int? totalMoney;
  int? point;
  String? animal_type;

  PaymentPage({
    Key? key,
    this.payMethod,
    this.merchantUid,
    this.totalMoney,
    this.point,
    this.animal_type,
  }) : super(key: key) {
    this.payMethod ??= "card";
    this.merchantUid ??= "";
    this.totalMoney ??= 0;
    this.point ??= 0;
    this.animal_type ??= "";
  }

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends BaseState<PaymentPage> {
  String title = "";
  String payMethod = "";

  @override
  void initState() {
    super.initState();
    if (widget.payMethod == "card") {
      title = LanguageService.trans("card_pay");
      payMethod = "card";
    } else if (widget.payMethod == "bank") {
      title = LanguageService.trans("bank_transfer");
      payMethod = "trans";
    } else if (widget.payMethod == "phone") {
      title = LanguageService.trans("phone_pay");
      payMethod = "phone";
    }
    setState(() {});

    event.on<payFinish>().listen((event) {
      if (mounted) {
        Navigator.push(
          context,
          SlideRightTransRoute(
            builder: (context) => BloodTestAppCompletePage(animalType: "dog", reservationId: ""),
          ),
        );
      }
    });
  }

  Future<bool> onBackPressed() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return IamportPayment(
      appBar: AppBar(
        title: Text(title),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //Image.asset('assets/images/iamport-logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp72270815',
      /* [필수입력] 결제 데이터 */
      data: PaymentData(
        pg: 'html5_inicis', // PG사
        payMethod: payMethod, // 결제수단
        name: LanguageService.trans("blood_test_app"), // 주문명
        merchantUid: widget.merchantUid!, // 주문번호
        amount: widget.totalMoney!, // 결제금액
        buyerName: user.info.name, // 구매자 이름
        buyerTel: user.info.phone_number, // 구매자 연락처
        buyerEmail: user.info.email, // 구매자 이메일
        buyerAddr: user.info.address + " " + user.info.address_detail, // 구매자 주소
        buyerPostcode: user.info.zip_code, // 구매자 우편번호
        appScheme: 'decapet', // 앱 URL scheme
        displayCardQuota: [2, 3], //결제창 UI 내 할부개월수 제한
        digital: false,
        mRedirectUrl: REDIRECT_URL,
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        /*
        String status = result["success"] ?? ""; //성공 여부
        print(status);
        String imp_uid = result["imp_uid"] ?? ""; //아임포트 번호
        print(imp_uid);
        String merchant_uid = result["merchant_uid"] ?? ""; //주문번호
        print(merchant_uid);
        String error_msg = result["error_msg"] ?? ""; //실패한 경우, 에러메시지
        print(error_msg);

        payConfirm(imp_uid, merchant_uid);

        String makeContent = "";
        makeContent = "성공 여부 : " + status;
        makeContent = makeContent + "\n아임포트 번호 : " + imp_uid;
        makeContent = makeContent + "\n주문번호 : " + merchant_uid;
        makeContent = makeContent + "\n실패한 경우, 에러메시지 : " + error_msg;
        showDialog(context: context, builder: (_) => OneBtnTitleDialog(title: title, content: makeContent));
         */
      },
    );
  }
}
