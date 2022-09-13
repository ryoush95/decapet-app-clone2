import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class HospitalDetailItemDto {
  String imgPath;
  String content;
  String percent;

  HospitalDetailItemDto({
    required this.imgPath,
    required this.content,
    required this.percent,
  });
}

@JsonSerializable()
class HospitalVerifiedItemDto {
  bool isVerified;
  String hospitalName;
  String formattedDate;
  String money;
  String favorNum;
  bool favorStat;

  HospitalVerifiedItemDto({
    required this.isVerified,
    required this.hospitalName,
    required this.formattedDate,
    required this.money,
    required this.favorNum,
    required this.favorStat,
  });
}