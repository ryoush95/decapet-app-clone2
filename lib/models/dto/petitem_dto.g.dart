// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petitem_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetItemDto _$PetItemDtoFromJson(Map<String, dynamic> json) => PetItemDto(
      name: json['name'] as String? ?? "",
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$PetItemDtoToJson(PetItemDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'content': instance.content,
    };
