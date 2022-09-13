import 'package:decapet/models/dto/pet_img_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'pet_img_res_model.g.dart';

@JsonSerializable()
class PetImageResModel extends ApiResModel {
  PetImageDto? data;

  PetImageResModel({this.data}) : super();

  factory PetImageResModel.fromJson(Map<String, dynamic> json) {
    PetImageResModel model = json['data'] != null ? _$PetImageResModelFromJson(json) : PetImageResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }

  Map toJson() => _$PetImageResModelToJson(this);
}
