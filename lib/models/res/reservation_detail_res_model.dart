import 'package:decapet/models/dto/reservation_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'reservation_detail_res_model.g.dart';

@JsonSerializable()
class ReservationDetailResModel extends ApiResModel {
  ReservationDto? data;

  ReservationDetailResModel({this.data});

  factory ReservationDetailResModel.fromJson(Map<String, dynamic> json) {
    ReservationDetailResModel model = json['data'] != null ? _$ReservationDetailResModelFromJson(json) : ReservationDetailResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
