// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_list_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmListResModel _$AlarmListResModelFromJson(Map<String, dynamic> json) =>
    AlarmListResModel(
      data: json['data'] == null
          ? null
          : AlarmListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$AlarmListResModelToJson(AlarmListResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
