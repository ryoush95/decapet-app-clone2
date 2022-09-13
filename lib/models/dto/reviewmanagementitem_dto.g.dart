// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewmanagementitem_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewManagementItemDto _$ReviewManagementItemDtoFromJson(
        Map<String, dynamic> json) =>
    ReviewManagementItemDto(
      path: json['path'] as String? ?? "",
      title: json['title'] as String? ?? "",
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$ReviewManagementItemDtoToJson(
        ReviewManagementItemDto instance) =>
    <String, dynamic>{
      'path': instance.path,
      'title': instance.title,
      'name': instance.name,
    };
