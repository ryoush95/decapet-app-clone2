// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'br_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BRDto _$BRDtoFromJson(Map<String, dynamic> json) => BRDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      name: json['name'] as String? ?? "",
      reference_min: json['reference_min'] as String? ?? "",
      reference_max: json['reference_max'] as String? ?? "",
      unit: json['unit'] as String? ?? "",
      date: json['date'] as String? ?? "",
      value: json['value'] as String? ?? "",
      type: json['type'] as String? ?? "",
    );

Map<String, dynamic> _$BRDtoToJson(BRDto instance) => <String, dynamic>{
      'id': toJsonInt(instance.id),
      'name': instance.name,
      'reference_min': instance.reference_min,
      'reference_max': instance.reference_max,
      'unit': instance.unit,
      'date': instance.date,
      'value': instance.value,
      'type': instance.type,
    };

BRListDto _$BRListDtoFromJson(Map<String, dynamic> json) => BRListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => BRDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      dates: json['dates'] as String,
      cbc_cnt: fromJsonInt(json['cbc_cnt']),
      sdma_cnt: fromJsonInt(json['sdma_cnt']),
      electro_cnt: fromJsonInt(json['electro_cnt']),
      pro_cnt: fromJsonInt(json['pro_cnt']),
      serum_cnt: fromJsonInt(json['serum_cnt']),
    );

Map<String, dynamic> _$BRListDtoToJson(BRListDto instance) => <String, dynamic>{
      'list': instance.list,
      'dates': instance.dates,
      'cbc_cnt': toJsonInt(instance.cbc_cnt),
      'serum_cnt': toJsonInt(instance.serum_cnt),
      'electro_cnt': toJsonInt(instance.electro_cnt),
      'sdma_cnt': toJsonInt(instance.sdma_cnt),
      'pro_cnt': toJsonInt(instance.pro_cnt),
    };
