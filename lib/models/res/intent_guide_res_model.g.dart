// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intent_guide_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntentGuideResModel _$IntentGuideResModelFromJson(Map<String, dynamic> json) =>
    IntentGuideResModel(
      data: json['data'] as String?,
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$IntentGuideResModelToJson(
        IntentGuideResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
