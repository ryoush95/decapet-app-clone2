// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_equipment_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalEquipmentResModel _$HospitalEquipmentResModelFromJson(
        Map<String, dynamic> json) =>
    HospitalEquipmentResModel(
      data: json['data'] == null
          ? null
          : HospitalEquipmentListDto.fromJson(
              json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$HospitalEquipmentResModelToJson(
        HospitalEquipmentResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
