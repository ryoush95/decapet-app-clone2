// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_list_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringListResModel _$StringListResModelFromJson(Map<String, dynamic> json) =>
    StringListResModel(
      data: json['data'] == null
          ? null
          : StringListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$StringListResModelToJson(StringListResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
