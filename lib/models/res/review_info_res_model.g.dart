// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_info_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewInfoResModel _$ReviewInfoResModelFromJson(Map<String, dynamic> json) =>
    ReviewInfoResModel(
      data: json['data'] == null
          ? null
          : ReviewInfoDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$ReviewInfoResModelToJson(ReviewInfoResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
