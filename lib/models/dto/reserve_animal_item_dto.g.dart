// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_animal_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReserveAnimalItemDto _$ReserveAnimalItemDtoFromJson(
        Map<String, dynamic> json) =>
    ReserveAnimalItemDto(
      content_1: json['content_1'] as String,
      content_2: json['content_2'] as String,
      content_3: json['content_3'] as String,
      content_4: json['content_4'] as String,
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
    );

Map<String, dynamic> _$ReserveAnimalItemDtoToJson(
        ReserveAnimalItemDto instance) =>
    <String, dynamic>{
      'content_1': instance.content_1,
      'content_2': instance.content_2,
      'content_3': instance.content_3,
      'content_4': instance.content_4,
      'id': toJsonInt(instance.id),
    };
