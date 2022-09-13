import 'package:json_annotation/json_annotation.dart';

part 'app_info1_dto.g.dart';

@JsonSerializable()
class AppInfo1Dto {
  late bool review;
  late bool stable;
  late String email;
  late List<ServiceDto> hospital_services;

  AppInfo1Dto({
    this.review = false,
    this.stable = false,
    this.email = "",
  });

  factory AppInfo1Dto.fromJson(Map<String, dynamic> json) => _$AppInfo1DtoFromJson(json);

  Map toJson() => _$AppInfo1DtoToJson(this);
}

@JsonSerializable()
class ServiceDto {
  late String full_name;
  late String short_name;

  ServiceDto({
    this.full_name = "",
    this.short_name = "",
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json) => _$ServiceDtoFromJson(json);

  Map toJson() => _$ServiceDtoToJson(this);
}
