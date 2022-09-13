import 'package:decapet/models/dto/cert_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_res_model.dart';

part 'cert_res_model.g.dart';

@JsonSerializable()
class CertResModel extends ApiResModel {
  CertDto? data;

  CertResModel({this.data}) : super();

  factory CertResModel.fromJson(Map<String, dynamic> json) {
    CertResModel model =
        json['data'] != null ? _$CertResModelFromJson(json) : CertResModel();
    model.fromJson(json); // parse api_res_model
    return model;
  }
}
