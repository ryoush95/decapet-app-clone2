// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfoDto _$AppInfoDtoFromJson(Map<String, dynamic> json) => AppInfoDto(
      alarm_cnt: json['alarm_cnt'] == null ? 0 : fromJsonInt(json['alarm_cnt']),
      my_point: json['my_point'] == null ? 0 : fromJsonInt(json['my_point']),
      pet_cnt: json['pet_cnt'] == null ? 0 : fromJsonInt(json['pet_cnt']),
      reserve_cnt:
          json['reserve_cnt'] == null ? 0 : fromJsonInt(json['reserve_cnt']),
      reserve_past_cnt: json['reserve_past_cnt'] == null
          ? 0
          : fromJsonInt(json['reserve_past_cnt']),
    );

Map<String, dynamic> _$AppInfoDtoToJson(AppInfoDto instance) =>
    <String, dynamic>{
      'alarm_cnt': toJsonInt(instance.alarm_cnt),
      'my_point': toJsonInt(instance.my_point),
      'pet_cnt': toJsonInt(instance.pet_cnt),
      'reserve_cnt': toJsonInt(instance.reserve_cnt),
      'reserve_past_cnt': toJsonInt(instance.reserve_past_cnt),
    };
