// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadDto _$UploadDtoFromJson(Map<String, dynamic> json) => UploadDto(
      file_urls:
          (json['file_urls'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UploadDtoToJson(UploadDto instance) => <String, dynamic>{
      'file_urls': instance.file_urls,
    };
