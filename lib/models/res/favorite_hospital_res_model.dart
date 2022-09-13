import 'package:decapet/models/dto/favorite_hospital_dto.dart';
import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:decapet/models/dto/point_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'favorite_hospital_res_model.g.dart';

@JsonSerializable()
class FavoriteHospitalResModel extends ApiResModel {
  FavoriteHospitalListDto? data;

  FavoriteHospitalResModel({this.data});

  factory FavoriteHospitalResModel.fromJson(Map<String, dynamic> json) {
    FavoriteHospitalResModel model =
    json['data'] != null ? _$FavoriteHospitalResModelFromJson(json) : FavoriteHospitalResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
