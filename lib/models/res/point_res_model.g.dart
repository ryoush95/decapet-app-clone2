// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointListResModel _$PointListResModelFromJson(Map<String, dynamic> json) =>
    PointListResModel(
      data: json['data'] == null
          ? null
          : PointListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$PointListResModelToJson(PointListResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
