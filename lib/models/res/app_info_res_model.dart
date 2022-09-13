import 'package:decapet/models/dto/app_info_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:decapet/models/dto/user_dto.dart';

import 'api_res_model.dart';

part 'app_info_res_model.g.dart';

@JsonSerializable()
class AppInfoResModel extends ApiResModel {
  AppInfoDto? data;

  AppInfoResModel({this.data}) : super();

  factory AppInfoResModel.fromJson(Map<String, dynamic> json) {
    AppInfoResModel model =
        json['data'] != null ? _$AppInfoResModelFromJson(json) : AppInfoResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
