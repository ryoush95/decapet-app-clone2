import 'package:decapet/helpers/common_util.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/helpers/transition.dart';
import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/components/h14.dart';
import 'package:decapet/pages/components/h20.dart';

import 'hospital_detail_body.dart';

class HospitalDetailPage extends StatefulWidget {
  @override
  HospitalDetailPageState createState() => HospitalDetailPageState();

  final int hospitalId;
  final String hospitalName;

  HospitalDetailPage({
    Key? key,
    required this.hospitalId,
    required this.hospitalName,
  }) : super(key: key);
}

class HospitalDetailPageState extends BaseState<HospitalDetailPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isLoading: isLoading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HospitalDetailHeaderPage(),
            const SizedBox(height: 20),
            HospitalDetailBodyPage(hospitalID: widget.hospitalId, hospitalName: widget.hospitalName),
            // HospitalDetailBottomPage(),
          ],
        ),
      ),
    );
  }
}
