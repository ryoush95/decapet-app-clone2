import 'package:decapet/helpers/common_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_dto.g.dart';

@JsonSerializable()
class UploadDto {
  List<String> file_urls;

  UploadDto({required this.file_urls}) : super();

  factory UploadDto.fromJson(Map<String, dynamic> json) =>
      _$UploadDtoFromJson(json);
}
