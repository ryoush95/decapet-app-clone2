// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_detail_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationDetailResModel _$ReservationDetailResModelFromJson(
        Map<String, dynamic> json) =>
    ReservationDetailResModel(
      data: json['data'] == null
          ? null
          : ReservationDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$ReservationDetailResModelToJson(
        ReservationDetailResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
