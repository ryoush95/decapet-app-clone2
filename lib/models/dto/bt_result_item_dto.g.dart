// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bt_result_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BtResultItemDto _$BtResultItemDtoFromJson(Map<String, dynamic> json) =>
    BtResultItemDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      name: json['name'] as String? ?? "",
      unit: json['unit'] as String? ?? "",
      value: json['value'] as String? ?? "",
      refer_max: json['refer_max'] as String? ?? "",
      refer_min: json['refer_min'] as String? ?? "",
    );

Map<String, dynamic> _$BtResultItemDtoToJson(BtResultItemDto instance) =>
    <String, dynamic>{
      'id': toJsonInt(instance.id),
      'name': instance.name,
      'unit': instance.unit,
      'value': instance.value,
      'refer_max': instance.refer_max,
      'refer_min': instance.refer_min,
    };

BtResultListDto _$BtResultListDtoFromJson(Map<String, dynamic> json) =>
    BtResultListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => BtResultItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BtResultListDtoToJson(BtResultListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
