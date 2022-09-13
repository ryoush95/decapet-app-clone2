// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_service_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalServiceResModel _$HospitalServiceResModelFromJson(
        Map<String, dynamic> json) =>
    HospitalServiceResModel(
      data: json['data'] == null
          ? null
          : HospitalServiceListDto.fromJson(
              json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$HospitalServiceResModelToJson(
        HospitalServiceResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
