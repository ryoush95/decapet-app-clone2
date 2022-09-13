// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResModel _$ReviewResModelFromJson(Map<String, dynamic> json) =>
    ReviewResModel(
      data: json['data'] == null
          ? null
          : ReviewDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$ReviewResModelToJson(ReviewResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };

ReviewListResModel _$ReviewListResModelFromJson(Map<String, dynamic> json) =>
    ReviewListResModel(
      data: json['data'] == null
          ? null
          : ReviewListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$ReviewListResModelToJson(ReviewListResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
