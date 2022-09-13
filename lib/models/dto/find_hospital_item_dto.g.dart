// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_hospital_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindHospitalItemDto _$FindHospitalItemDtoFromJson(Map<String, dynamic> json) =>
    FindHospitalItemDto(
      title: json['title'] as String,
      content_1: json['content_1'] as String,
      content_2: json['content_2'] as String,
      type: fromJsonInt(json['type']),
      fav_num: json['fav_num'] as String,
      review_num: json['review_num'] as String,
      distance: json['distance'] as String,
    );

Map<String, dynamic> _$FindHospitalItemDtoToJson(
        FindHospitalItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content_1': instance.content_1,
      'content_2': instance.content_2,
      'fav_num': instance.fav_num,
      'review_num': instance.review_num,
      'distance': instance.distance,
      'type': toJsonInt(instance.type),
    };
