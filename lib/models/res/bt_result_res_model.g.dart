// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bt_result_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BtResultResModel _$BtResultResModelFromJson(Map<String, dynamic> json) =>
    BtResultResModel(
      data: json['data'] == null
          ? null
          : BtResultListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$BtResultResModelToJson(BtResultResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
