// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResModel _$ApiResModelFromJson(Map<String, dynamic> json) => ApiResModel(
      result: json['result'] as int?,
      msg: json['msg'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$ApiResModelToJson(ApiResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
    };
