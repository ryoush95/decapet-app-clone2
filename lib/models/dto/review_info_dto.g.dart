// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewInfoDto _$ReviewInfoDtoFromJson(Map<String, dynamic> json) =>
    ReviewInfoDto(
      total_user_cnt: json['total_user_cnt'] == null
          ? 0
          : fromJsonInt(json['total_user_cnt']),
      reviewer_cnt:
          json['reviewer_cnt'] == null ? 0 : fromJsonInt(json['reviewer_cnt']),
      feeling_percents: json['feeling_percents'] as String? ?? "",
      purpose_cnts: json['purpose_cnts'] as String? ?? "",
    );

Map<String, dynamic> _$ReviewInfoDtoToJson(ReviewInfoDto instance) =>
    <String, dynamic>{
      'total_user_cnt': toJsonInt(instance.total_user_cnt),
      'reviewer_cnt': toJsonInt(instance.reviewer_cnt),
      'feeling_percents': instance.feeling_percents,
      'purpose_cnts': instance.purpose_cnts,
    };
