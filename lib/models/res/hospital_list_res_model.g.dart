// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_list_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalListResModel _$HospitalListResModelFromJson(
        Map<String, dynamic> json) =>
    HospitalListResModel(
      data: json['data'] == null
          ? null
          : HospitalListDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$HospitalListResModelToJson(
        HospitalListResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
