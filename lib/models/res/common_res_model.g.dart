// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResModel _$CommonResModelFromJson(Map<String, dynamic> json) =>
    CommonResModel(
      data: json['data'] == null
          ? null
          : CommonDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$CommonResModelToJson(CommonResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
