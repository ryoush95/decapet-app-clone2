// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfoResModel _$AppInfoResModelFromJson(Map<String, dynamic> json) =>
    AppInfoResModel(
      data: json['data'] == null
          ? null
          : AppInfoDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$AppInfoResModelToJson(AppInfoResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
