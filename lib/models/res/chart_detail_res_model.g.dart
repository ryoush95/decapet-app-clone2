// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_detail_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartDetailResModel _$ChartDetailResModelFromJson(Map<String, dynamic> json) =>
    ChartDetailResModel(
      data: json['data'] == null
          ? null
          : ChartDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$ChartDetailResModelToJson(
        ChartDetailResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
