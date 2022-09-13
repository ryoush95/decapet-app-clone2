// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_list_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationListResModel _$ReservationListResModelFromJson(
        Map<String, dynamic> json) =>
    ReservationListResModel(
      data: json['data'] == null
          ? null
          : ReservationListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$ReservationListResModelToJson(
        ReservationListResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
