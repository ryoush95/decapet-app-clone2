// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_chart_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentChartItemDto _$TreatmentChartItemDtoFromJson(
        Map<String, dynamic> json) =>
    TreatmentChartItemDto(
      title: json['title'] as String,
      content_1: json['content_1'] as String,
      content_2: json['content_2'] as String,
      content_3: json['content_3'] as String,
      type: fromJsonInt(json['type']),
    );

Map<String, dynamic> _$TreatmentChartItemDtoToJson(
        TreatmentChartItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content_1': instance.content_1,
      'content_2': instance.content_2,
      'content_3': instance.content_3,
      'type': toJsonInt(instance.type),
    };
