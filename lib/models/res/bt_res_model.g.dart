// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bt_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BtResModel _$BtResModelFromJson(Map<String, dynamic> json) => BtResModel(
      data: json['data'] == null
          ? null
          : BtListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$BtResModelToJson(BtResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
