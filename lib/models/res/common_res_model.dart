import 'package:decapet/models/dto/bt_dto.dart';
import 'package:decapet/models/dto/common_dto.dart';
import 'package:decapet/models/dto/drug_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'common_res_model.g.dart';

@JsonSerializable()
class CommonResModel extends ApiResModel {
  CommonDto? data;

  CommonResModel({this.data});

  factory CommonResModel.fromJson(Map<String, dynamic> json) {
    CommonResModel model = json['data'] != null
        ? _$CommonResModelFromJson(json)
        : CommonResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
