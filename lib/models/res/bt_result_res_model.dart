import 'package:decapet/models/dto/bt_result_item_dto.dart';
import 'package:decapet/models/dto/chart_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'bt_result_res_model.g.dart';

@JsonSerializable()
class BtResultResModel extends ApiResModel {
  BtResultListDto? data;

  BtResultResModel({this.data});

  factory BtResultResModel.fromJson(Map<String, dynamic> json) {
    BtResultResModel model = json['data'] != null
        ? _$BtResultResModelFromJson(json)
        : BtResultResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
