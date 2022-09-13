import 'package:decapet/models/dto/alarm_dto.dart';
import 'package:decapet/models/dto/chart_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'alarm_list_res_model.g.dart';

@JsonSerializable()
class AlarmListResModel extends ApiResModel {
  AlarmListDto? data;

  AlarmListResModel({this.data});

  factory AlarmListResModel.fromJson(Map<String, dynamic> json) {
    AlarmListResModel model = json['data'] != null
        ? _$AlarmListResModelFromJson(json)
        : AlarmListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}