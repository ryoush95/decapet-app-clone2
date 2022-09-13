// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inoculation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InoculationDto _$InoculationDtoFromJson(Map<String, dynamic> json) =>
    InoculationDto(
      drug_id: json['drug_id'] == null ? 0 : fromJsonInt(json['drug_id']),
      drug_name: json['drug_name'] as String? ?? "",
      inoculation_date: json['inoculation_date'] as String? ?? "",
    );

Map<String, dynamic> _$InoculationDtoToJson(InoculationDto instance) =>
    <String, dynamic>{
      'drug_id': toJsonInt(instance.drug_id),
      'drug_name': instance.drug_name,
      'inoculation_date': instance.inoculation_date,
    };
