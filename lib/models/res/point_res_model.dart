import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/models/dto/point_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'point_res_model.g.dart';

@JsonSerializable()
class PointListResModel extends ApiResModel {
  PointListDto? data;

  PointListResModel({this.data});

  factory PointListResModel.fromJson(Map<String, dynamic> json) {
    PointListResModel model =
    json['data'] != null ? _$PointListResModelFromJson(json) : PointListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
