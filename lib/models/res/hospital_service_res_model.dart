import 'package:decapet/models/dto/alarm_dto.dart';
import 'package:decapet/models/dto/chart_dto.dart';
import 'package:decapet/models/dto/hospital_service_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'hospital_service_res_model.g.dart';

@JsonSerializable()
class HospitalServiceResModel extends ApiResModel {
  HospitalServiceListDto? data;

  HospitalServiceResModel({this.data});

  factory HospitalServiceResModel.fromJson(Map<String, dynamic> json) {
    HospitalServiceResModel model = json['data'] != null
        ? _$HospitalServiceResModelFromJson(json)
        : HospitalServiceResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}