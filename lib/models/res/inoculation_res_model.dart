import 'package:decapet/models/dto/br_dto.dart';
import 'package:decapet/models/dto/bt_dto.dart';
import 'package:decapet/models/dto/inoculation_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'inoculation_res_model.g.dart';

@JsonSerializable()
class InoculationResModel extends ApiResModel {
  InoculationDto? data;

  InoculationResModel({this.data});

  factory InoculationResModel.fromJson(Map<String, dynamic> json) {
    InoculationResModel model = json['data'] != null
        ? _$InoculationResModelFromJson(json)
        : InoculationResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
