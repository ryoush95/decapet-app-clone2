// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_equipment_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalEquipmentItemDto _$HospitalEquipmentItemDtoFromJson(
        Map<String, dynamic> json) =>
    HospitalEquipmentItemDto(
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$HospitalEquipmentItemDtoToJson(
        HospitalEquipmentItemDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

HospitalEquipmentListDto _$HospitalEquipmentListDtoFromJson(
        Map<String, dynamic> json) =>
    HospitalEquipmentListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) =>
              HospitalEquipmentItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HospitalEquipmentListDtoToJson(
        HospitalEquipmentListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
