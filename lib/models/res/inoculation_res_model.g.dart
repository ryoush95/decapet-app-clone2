// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inoculation_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InoculationResModel _$InoculationResModelFromJson(Map<String, dynamic> json) =>
    InoculationResModel(
      data: json['data'] == null
          ? null
          : InoculationDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$InoculationResModelToJson(
        InoculationResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
