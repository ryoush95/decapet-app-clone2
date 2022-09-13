import 'package:decapet/models/dto/review_info_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'review_info_res_model.g.dart';

@JsonSerializable()
class ReviewInfoResModel extends ApiResModel {
  ReviewInfoDto? data;

  ReviewInfoResModel({this.data});

  factory ReviewInfoResModel.fromJson(Map<String, dynamic> json) {
    ReviewInfoResModel model = json['data'] != null
        ? _$ReviewInfoResModelFromJson(json)
        : ReviewInfoResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
