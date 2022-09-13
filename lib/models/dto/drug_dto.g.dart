// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugItemDto _$DrugItemDtoFromJson(Map<String, dynamic> json) => DrugItemDto(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      animal_type: json['animal_type'] as String? ?? "",
      period: json['period'] as String? ?? "",
      drug_type: json['drug_type'] as String? ?? "",
    );

Map<String, dynamic> _$DrugItemDtoToJson(DrugItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'animal_type': instance.animal_type,
      'period': instance.period,
      'drug_type': instance.drug_type,
    };

DrugListDto _$DrugListDtoFromJson(Map<String, dynamic> json) => DrugListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => DrugItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DrugListDtoToJson(DrugListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
