// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info1_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo1ResModel _$AppInfo1ResModelFromJson(Map<String, dynamic> json) =>
    AppInfo1ResModel(
      data: json['data'] == null
          ? null
          : AppInfo1Dto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$AppInfo1ResModelToJson(AppInfo1ResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
