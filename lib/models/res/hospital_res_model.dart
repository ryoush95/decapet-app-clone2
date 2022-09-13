import 'package:decapet/models/dto/favorite_hospital_dto.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:decapet/models/dto/point_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'hospital_res_model.g.dart';

@JsonSerializable()
class HospitalResModel extends ApiResModel {
  HospitalListDto? data;

  HospitalResModel({this.data});

  factory HospitalResModel.fromJson(Map<String, dynamic> json) {
    HospitalResModel model =
    json['data'] != null ? _$HospitalResModelFromJson(json) : HospitalResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
