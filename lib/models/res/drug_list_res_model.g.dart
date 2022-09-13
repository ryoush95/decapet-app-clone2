// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_list_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugListResModel _$DrugListResModelFromJson(Map<String, dynamic> json) =>
    DrugListResModel(
      data: json['data'] == null
          ? null
          : DrugListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$DrugListResModelToJson(DrugListResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
