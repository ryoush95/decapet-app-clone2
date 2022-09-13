// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospitalitem_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalItemDto _$HospitalItemDtoFromJson(Map<String, dynamic> json) =>
    HospitalItemDto(
      name: json['name'] as String? ?? "",
      address: json['address'] as String? ?? "",
      likepoint: json['likepoint'] == null ? 0 : fromJsonInt(json['likepoint']),
    );

Map<String, dynamic> _$HospitalItemDtoToJson(HospitalItemDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'likepoint': toJsonInt(instance.likepoint),
    };
