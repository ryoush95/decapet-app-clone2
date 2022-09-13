import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_info_dto.g.dart';

@JsonSerializable()
class AppInfoDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int alarm_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int my_point;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int pet_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int reserve_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int reserve_past_cnt;

  AppInfoDto({
    this.alarm_cnt = 0,
    this.my_point = 0,
    this.pet_cnt = 0,
    this.reserve_cnt = 0,
    this.reserve_past_cnt = 0,
  });

  factory AppInfoDto.fromJson(Map<String, dynamic> json) => _$AppInfoDtoFromJson(json);

  Map toJson() => _$AppInfoDtoToJson(this);
}
