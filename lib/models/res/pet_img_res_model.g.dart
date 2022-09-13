// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_img_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetImageResModel _$PetImageResModelFromJson(Map<String, dynamic> json) =>
    PetImageResModel(
      data: json['data'] == null
          ? null
          : PetImageDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$PetImageResModelToJson(PetImageResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
