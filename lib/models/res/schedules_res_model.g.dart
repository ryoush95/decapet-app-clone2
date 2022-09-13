// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedules_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchedulesResModel _$SchedulesResModelFromJson(Map<String, dynamic> json) =>
    SchedulesResModel(
      data: json['data'] == null
          ? null
          : SchedulesListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$SchedulesResModelToJson(SchedulesResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
