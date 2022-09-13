import 'package:decapet/models/dto/chart_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'chart_detail_res_model.g.dart';

@JsonSerializable()
class ChartDetailResModel extends ApiResModel {
  ChartDto? data;

  ChartDetailResModel({this.data});

  factory ChartDetailResModel.fromJson(Map<String, dynamic> json) {
    ChartDetailResModel model = json['data'] != null
        ? _$ChartDetailResModelFromJson(json)
        : ChartDetailResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
