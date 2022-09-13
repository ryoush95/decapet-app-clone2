import 'package:decapet/models/dto/string_list_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'string_list_res_model.g.dart';

@JsonSerializable()
class StringListResModel extends ApiResModel {
  StringListDto? data;

  StringListResModel({this.data});

  factory StringListResModel.fromJson(Map<String, dynamic> json) {
    StringListResModel model =
    json['data'] != null ? _$StringListResModelFromJson(json) : StringListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
