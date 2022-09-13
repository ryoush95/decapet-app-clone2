// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedules_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchedulesDto _$SchedulesDtoFromJson(Map<String, dynamic> json) => SchedulesDto(
      id: json['id'] as String? ?? "",
      hospital_id: json['hospital_id'] as String? ?? "",
      day_type: json['day_type'] as String? ?? "",
      is_dayoff: json['is_dayoff'] as String? ?? "",
      start_time: json['start_time'] as String? ?? "",
      end_time: json['end_time'] as String? ?? "",
      created_at: json['created_at'] as String? ?? "",
      updated_at: json['updated_at'] as String? ?? "",
      available: json['available'] as String? ?? "",
    );

Map<String, dynamic> _$SchedulesDtoToJson(SchedulesDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hospital_id': instance.hospital_id,
      'day_type': instance.day_type,
      'is_dayoff': instance.is_dayoff,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'available': instance.available,
    };

SchedulesListDto _$SchedulesListDtoFromJson(Map<String, dynamic> json) =>
    SchedulesListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => SchedulesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      special: (json['special'] as List<dynamic>)
          .map((e) => SchedulesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchedulesListDtoToJson(SchedulesListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'special': instance.special,
    };
