// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bottom_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBottomItemDto _$HomeBottomItemDtoFromJson(Map<String, dynamic> json) =>
    HomeBottomItemDto(
      title: json['title'] as String,
      content_image: json['content_image'] as String,
      content_text: json['content_text'] as String,
      content_digit: fromJsonInt(json['content_digit']),
      type: json['type'] as int,
    );

Map<String, dynamic> _$HomeBottomItemDtoToJson(HomeBottomItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content_image': instance.content_image,
      'content_text': instance.content_text,
      'content_digit': toJsonInt(instance.content_digit),
      'type': instance.type,
    };
