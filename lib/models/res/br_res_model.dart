import 'package:decapet/models/dto/br_dto.dart';
import 'package:decapet/models/dto/bt_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'br_res_model.g.dart';

@JsonSerializable()
class BRResModel extends ApiResModel {
  BRListDto? data;

  BRResModel({this.data});

  factory BRResModel.fromJson(Map<String, dynamic> json) {
    BRResModel model = json['data'] != null
        ? _$BRResModelFromJson(json)
        : BRResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
