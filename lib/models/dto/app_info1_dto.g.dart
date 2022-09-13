// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info1_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo1Dto _$AppInfo1DtoFromJson(Map<String, dynamic> json) => AppInfo1Dto(
      review: json['review'] as bool? ?? false,
      stable: json['stable'] as bool? ?? false,
      email: json['email'] as String? ?? "",
    )..hospital_services = (json['hospital_services'] as List<dynamic>)
        .map((e) => ServiceDto.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$AppInfo1DtoToJson(AppInfo1Dto instance) =>
    <String, dynamic>{
      'review': instance.review,
      'stable': instance.stable,
      'email': instance.email,
      'hospital_services': instance.hospital_services,
    };

ServiceDto _$ServiceDtoFromJson(Map<String, dynamic> json) => ServiceDto(
      full_name: json['full_name'] as String? ?? "",
      short_name: json['short_name'] as String? ?? "",
    );

Map<String, dynamic> _$ServiceDtoToJson(ServiceDto instance) =>
    <String, dynamic>{
      'full_name': instance.full_name,
      'short_name': instance.short_name,
    };
