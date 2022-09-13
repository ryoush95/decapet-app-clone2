// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bt_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BtDto _$BtDtoFromJson(Map<String, dynamic> json) => BtDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      name: json['name'] as String? ?? "",
      item_type: json['item_type'] as String? ?? "",
      type: json['type'] as String? ?? "",
      detail: json['detail'] as String? ?? "",
      price: json['price'] == null ? 0 : fromJsonInt(json['price']),
      reference_min: json['reference_min'] as String? ?? "",
      reference_max: json['reference_max'] as String? ?? "",
      unit: json['unit'] as String? ?? "",
    );

Map<String, dynamic> _$BtDtoToJson(BtDto instance) => <String, dynamic>{
      'id': toJsonInt(instance.id),
      'item_type': instance.item_type,
      'type': instance.type,
      'name': instance.name,
      'detail': instance.detail,
      'price': toJsonInt(instance.price),
      'reference_min': instance.reference_min,
      'reference_max': instance.reference_max,
      'unit': instance.unit,
    };

BtListDto _$BtListDtoFromJson(Map<String, dynamic> json) => BtListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => BtDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      cbc_cnt: fromJsonInt(json['cbc_cnt']),
      sdma_cnt: fromJsonInt(json['sdma_cnt']),
      electro_cnt: fromJsonInt(json['electro_cnt']),
      pro_cnt: fromJsonInt(json['pro_cnt']),
      serum_cnt: fromJsonInt(json['serum_cnt']),
    );

Map<String, dynamic> _$BtListDtoToJson(BtListDto instance) => <String, dynamic>{
      'list': instance.list,
      'cbc_cnt': toJsonInt(instance.cbc_cnt),
      'serum_cnt': toJsonInt(instance.serum_cnt),
      'electro_cnt': toJsonInt(instance.electro_cnt),
      'sdma_cnt': toJsonInt(instance.sdma_cnt),
      'pro_cnt': toJsonInt(instance.pro_cnt),
    };
