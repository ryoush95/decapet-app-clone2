// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_service_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalServiceItemDto _$HospitalServiceItemDtoFromJson(
        Map<String, dynamic> json) =>
    HospitalServiceItemDto(
      name: json['name'] as String? ?? "",
      price: json['price'] == null ? 0 : fromJsonInt(json['price']),
    );

Map<String, dynamic> _$HospitalServiceItemDtoToJson(
        HospitalServiceItemDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': toJsonInt(instance.price),
    };

HospitalServiceListDto _$HospitalServiceListDtoFromJson(
        Map<String, dynamic> json) =>
    HospitalServiceListDto(
      list: (json['list'] as List<dynamic>)
          .map(
              (e) => HospitalServiceItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HospitalServiceListDtoToJson(
        HospitalServiceListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
