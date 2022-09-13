import 'package:decapet/models/dto/cert_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'intent_guide_res_model.g.dart';

@JsonSerializable()
class IntentGuideResModel extends ApiResModel {
  String? data;

  IntentGuideResModel({this.data}) : super();

  factory IntentGuideResModel.fromJson(Map<String, dynamic> json) {
    IntentGuideResModel model =
    json['data'] != null ? _$IntentGuideResModelFromJson(json) : IntentGuideResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
