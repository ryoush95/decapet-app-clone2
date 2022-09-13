// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringListDto _$StringListDtoFromJson(Map<String, dynamic> json) =>
    StringListDto(
      list: (json['list'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$StringListDtoToJson(StringListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
