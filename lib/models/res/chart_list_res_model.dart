import 'package:decapet/models/dto/chart_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'chart_list_res_model.g.dart';

@JsonSerializable()
class ChartListResModel extends ApiResModel {
  ChartListDto? data;

  ChartListResModel({this.data});

  factory ChartListResModel.fromJson(Map<String, dynamic> json) {
    ChartListResModel model = json['data'] != null
        ? _$ChartListResModelFromJson(json)
        : ChartListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
