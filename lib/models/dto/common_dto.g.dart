// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonDto _$CommonDtoFromJson(Map<String, dynamic> json) => CommonDto(
      reservation_id: json['reservation_id'] == null
          ? 0
          : fromJsonInt(json['reservation_id']),
      animal_type: json['animal_type'] as String? ?? "",
      point: json['point'] == null ? 0 : fromJsonInt(json['point']),
    );

Map<String, dynamic> _$CommonDtoToJson(CommonDto instance) => <String, dynamic>{
      'reservation_id': toJsonInt(instance.reservation_id),
      'animal_type': instance.animal_type,
      'point': toJsonInt(instance.point),
    };
