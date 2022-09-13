// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_test_result_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodTestResultItemDto _$BloodTestResultItemDtoFromJson(
        Map<String, dynamic> json) =>
    BloodTestResultItemDto(
      title: json['title'] as String,
      row_count: fromJsonInt(json['row_count']),
      headers:
          (json['headers'] as List<dynamic>).map((e) => e as String).toList(),
      datas: (json['datas'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$BloodTestResultItemDtoToJson(
        BloodTestResultItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'headers': instance.headers,
      'datas': instance.datas,
      'row_count': toJsonInt(instance.row_count),
    };
