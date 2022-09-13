// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pointhistoryitem_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointHistoryItemDto _$PointHistoryItemDtoFromJson(Map<String, dynamic> json) =>
    PointHistoryItemDto(
      title: json['title'] as String? ?? "",
      content: json['content'] as String? ?? "",
      type: json['type'] == null ? 0 : fromJsonInt(json['type']),
      mark: json['mark'] as String? ?? "",
    );

Map<String, dynamic> _$PointHistoryItemDtoToJson(
        PointHistoryItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'type': toJsonInt(instance.type),
      'mark': instance.mark,
    };
