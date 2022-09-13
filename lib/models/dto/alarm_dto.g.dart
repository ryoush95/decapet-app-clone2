// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmDto _$AlarmDtoFromJson(Map<String, dynamic> json) => AlarmDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      title: json['title'] as String? ?? "",
      created_at: json['created_at'] as String? ?? "",
      description: json['description'] as String? ?? "",
      notification_type: json['notification_type'] as String? ?? "",
      target_id: json['target_id'] as String? ?? "",
    );

Map<String, dynamic> _$AlarmDtoToJson(AlarmDto instance) => <String, dynamic>{
      'id': toJsonInt(instance.id),
      'title': instance.title,
      'created_at': instance.created_at,
      'description': instance.description,
      'notification_type': instance.notification_type,
      'target_id': instance.target_id,
    };

AlarmListDto _$AlarmListDtoFromJson(Map<String, dynamic> json) => AlarmListDto(
      totalCount: fromJsonInt(json['totalCount']),
      totalPage: fromJsonInt(json['totalPage']),
      isLast: json['is_last'] as bool? ?? true,
      list: (json['list'] as List<dynamic>)
          .map((e) => AlarmDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlarmListDtoToJson(AlarmListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'totalCount': toJsonInt(instance.totalCount),
      'totalPage': toJsonInt(instance.totalPage),
      'is_last': instance.isLast,
    };
