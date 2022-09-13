import 'package:decapet/models/dto/bt_dto.dart';
import 'package:decapet/models/dto/drug_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'bt_res_model.g.dart';

@JsonSerializable()
class BtResModel extends ApiResModel {
  BtListDto? data;

  BtResModel({this.data});

  factory BtResModel.fromJson(Map<String, dynamic> json) {
    BtResModel model = json['data'] != null
        ? _$BtResModelFromJson(json)
        : BtResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
