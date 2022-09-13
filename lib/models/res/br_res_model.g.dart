// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'br_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BRResModel _$BRResModelFromJson(Map<String, dynamic> json) => BRResModel(
      data: json['data'] == null
          ? null
          : BRListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$BRResModelToJson(BRResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
