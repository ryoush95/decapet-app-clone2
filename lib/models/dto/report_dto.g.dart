// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDto _$ReportDtoFromJson(Map<String, dynamic> json) => ReportDto(
      report_uid:
          json['report_uid'] == null ? 0 : fromJsonInt(json['report_uid']),
      morning_time: json['morning_time'] as String? ?? '',
      morning_temperature: json['morning_temperature'] as String? ?? '',
      morning_saturation: json['morning_saturation'] as String? ?? '',
      morning_breath: json['morning_breath'] as String? ?? '',
      morning_symptom: json['morning_symptom'] as String? ?? '',
      morning_medication: json['morning_medication'] as String? ?? '',
      afternoon_time: json['afternoon_time'] as String? ?? '',
      afternoon_temperature: json['afternoon_temperature'] as String? ?? '',
      afternoon_saturation: json['afternoon_saturation'] as String? ?? '',
      afternoon_breath: json['afternoon_breath'] as String? ?? '',
      afternoon_symptom: json['afternoon_symptom'] as String? ?? '',
      afternoon_medication: json['afternoon_medication'] as String? ?? '',
    );

Map<String, dynamic> _$ReportDtoToJson(ReportDto instance) => <String, dynamic>{
      'report_uid': toJsonInt(instance.report_uid),
      'morning_time': instance.morning_time,
      'morning_temperature': instance.morning_temperature,
      'morning_saturation': instance.morning_saturation,
      'morning_symptom': instance.morning_symptom,
      'morning_breath': instance.morning_breath,
      'morning_medication': instance.morning_medication,
      'afternoon_time': instance.afternoon_time,
      'afternoon_temperature': instance.afternoon_temperature,
      'afternoon_saturation': instance.afternoon_saturation,
      'afternoon_breath': instance.afternoon_breath,
      'afternoon_symptom': instance.afternoon_symptom,
      'afternoon_medication': instance.afternoon_medication,
    };

ReportListDto _$ReportListDtoFromJson(Map<String, dynamic> json) =>
    ReportListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => ReportDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportListDtoToJson(ReportListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
