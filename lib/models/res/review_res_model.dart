import 'package:decapet/models/dto/chart_dto.dart';
import 'package:decapet/models/dto/review_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'review_res_model.g.dart';

@JsonSerializable()
class ReviewResModel extends ApiResModel {
  ReviewDto? data;

  ReviewResModel({this.data});

  factory ReviewResModel.fromJson(Map<String, dynamic> json) {
    ReviewResModel model = json['data'] != null
        ? _$ReviewResModelFromJson(json)
        : ReviewResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}

@JsonSerializable()
class ReviewListResModel extends ApiResModel {
  ReviewListDto? data;

  ReviewListResModel({this.data});

  factory ReviewListResModel.fromJson(Map<String, dynamic> json) {
    ReviewListResModel model = json['data'] != null
        ? _$ReviewListResModelFromJson(json)
        : ReviewListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}