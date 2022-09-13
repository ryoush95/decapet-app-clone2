import 'package:decapet/models/dto/drug_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'drug_list_res_model.g.dart';

@JsonSerializable()
class DrugListResModel extends ApiResModel {
  DrugListDto? data;

  DrugListResModel({this.data});

  factory DrugListResModel.fromJson(Map<String, dynamic> json) {
    DrugListResModel model = json['data'] != null ? _$DrugListResModelFromJson(json) : DrugListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
