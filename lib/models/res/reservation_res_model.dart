import 'package:decapet/models/dto/drug_dto.dart';
import 'package:decapet/models/dto/reservation_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'reservation_res_model.g.dart';

@JsonSerializable()
class ReservationResModel extends ApiResModel {
  ReservationDto? data;

  ReservationResModel({this.data});

  factory ReservationResModel.fromJson(Map<String, dynamic> json) {
    ReservationResModel model = json['data'] != null
        ? _$ReservationResModelFromJson(json)
        : ReservationResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}

@JsonSerializable()
class ReservationListResModel extends ApiResModel {
  ReservationListDto? data;

  ReservationListResModel({this.data});

  factory ReservationListResModel.fromJson(Map<String, dynamic> json) {
    ReservationListResModel model = json['data'] != null
        ? _$ReservationListResModelFromJson(json)
        : ReservationListResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
