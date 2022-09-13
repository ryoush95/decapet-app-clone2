// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => CategoryDto(
      category_uid:
          json['category_uid'] == null ? 0 : fromJsonInt(json['category_uid']),
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{
      'category_uid': toJsonInt(instance.category_uid),
      'category': instance.category,
    };

CategoryListDto _$CategoryListDtoFromJson(Map<String, dynamic> json) =>
    CategoryListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryListDtoToJson(CategoryListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
