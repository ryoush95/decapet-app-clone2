
import 'package:decapet/models/dto/hospital_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'hospital_list_res_model.g.dart';

@JsonSerializable()
class HospitalListResModel extends ApiResModel {
  HospitalListDto? data;

  HospitalListResModel({this.data});

  factory HospitalListResModel.fromJson(Map<String, dynamic> json) {
    HospitalListResModel model = json['data'] != null ? _$HospitalListResModelFromJson(json) : HospitalListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
