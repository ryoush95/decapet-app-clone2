import 'package:decapet/models/dto/schedules_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'schedules_res_model.g.dart';

@JsonSerializable()
class SchedulesResModel extends ApiResModel {
  SchedulesListDto? data;

  SchedulesResModel({this.data});

  factory SchedulesResModel.fromJson(Map<String, dynamic> json) {
    SchedulesResModel model = json['data'] != null ? _$SchedulesResModelFromJson(json) : SchedulesResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
