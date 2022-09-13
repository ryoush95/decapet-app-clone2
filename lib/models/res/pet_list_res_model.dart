import 'package:decapet/models/dto/home_pet_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'pet_list_res_model.g.dart';

@JsonSerializable()
class PetListResModel extends ApiResModel {
  PetListDto? data;

  PetListResModel({this.data});

  factory PetListResModel.fromJson(Map<String, dynamic> json) {
    PetListResModel model =
    json['data'] != null ? _$PetListResModelFromJson(json) : PetListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
