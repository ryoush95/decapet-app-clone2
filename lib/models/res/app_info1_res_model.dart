import 'package:decapet/models/dto/app_info1_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'app_info1_res_model.g.dart';

@JsonSerializable()
class AppInfo1ResModel extends ApiResModel {
  AppInfo1Dto? data;

  AppInfo1ResModel({this.data}) : super();

  factory AppInfo1ResModel.fromJson(Map<String, dynamic> json) {
    AppInfo1ResModel model = json['data'] != null ? _$AppInfo1ResModelFromJson(json) : AppInfo1ResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
