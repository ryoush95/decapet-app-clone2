// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResModel _$UploadResModelFromJson(Map<String, dynamic> json) =>
    UploadResModel(
      data: json['data'] == null
          ? null
          : UploadDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$UploadResModelToJson(UploadResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
