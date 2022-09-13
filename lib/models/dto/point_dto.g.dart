// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointDto _$PointDtoFromJson(Map<String, dynamic> json) => PointDto(
      type: json['type'] as String? ?? "",
      target_id: json['target_id'] == null ? 0 : fromJsonInt(json['target_id']),
      created_at: json['created_at'] as String? ?? "",
      point: json['point'] == null ? 0 : fromJsonInt(json['point']),
    );

Map<String, dynamic> _$PointDtoToJson(PointDto instance) => <String, dynamic>{
      'type': instance.type,
      'target_id': toJsonInt(instance.target_id),
      'created_at': instance.created_at,
      'point': toJsonInt(instance.point),
    };

PointListDto _$PointListDtoFromJson(Map<String, dynamic> json) => PointListDto(
      totalCount: fromJsonInt(json['totalCount']),
      totalPage: fromJsonInt(json['totalPage']),
      isLast: json['is_last'] as bool? ?? true,
      list: (json['list'] as List<dynamic>)
          .map((e) => PointDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PointListDtoToJson(PointListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'totalCount': toJsonInt(instance.totalCount),
      'totalPage': toJsonInt(instance.totalPage),
      'is_last': instance.isLast,
    };
