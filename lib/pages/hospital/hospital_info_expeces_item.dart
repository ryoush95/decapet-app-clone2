import 'package:decapet/language/language_service.dart';
import 'package:decapet/pages/components/h16.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/edge_insets.dart';

class HospitalInfoExpenseItem extends StatelessWidget {
  final String name;
  int? value;

  HospitalInfoExpenseItem({Key? key, required this.name, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  H16(
                    text: name,
                  ),
                  H16(
                    text: value == 0 ? "-" : (value.toString() + ' ' + LanguageService.trans("won")),
                  ),
                ],
              ),
              //SizedBox(height: 10,),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
