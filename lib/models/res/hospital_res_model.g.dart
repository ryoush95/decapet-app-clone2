// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalResModel _$HospitalResModelFromJson(Map<String, dynamic> json) =>
    HospitalResModel(
      data: json['data'] == null
          ? null
          : HospitalListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$HospitalResModelToJson(HospitalResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
