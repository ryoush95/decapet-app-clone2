// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_list_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartListResModel _$ChartListResModelFromJson(Map<String, dynamic> json) =>
    ChartListResModel(
      data: json['data'] == null
          ? null
          : ChartListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$ChartListResModelToJson(ChartListResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
