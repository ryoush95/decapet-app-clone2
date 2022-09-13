import 'package:decapet/models/dto/hospital_equipment_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'hospital_equipment_res_model.g.dart';

@JsonSerializable()
class HospitalEquipmentResModel extends ApiResModel {
  HospitalEquipmentListDto? data;

  HospitalEquipmentResModel({this.data});

  factory HospitalEquipmentResModel.fromJson(Map<String, dynamic> json) {
    HospitalEquipmentResModel model = json['data'] != null
        ? _$HospitalEquipmentResModelFromJson(json)
        : HospitalEquipmentResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}