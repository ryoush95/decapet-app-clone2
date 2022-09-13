import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm_dto.g.dart';

@JsonSerializable()
class AlarmDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  late String title;
  late String created_at;
  late String description;
  late String notification_type;
  late String target_id;

  AlarmDto({
    this.id = 0,
    this.title = "",
    this.created_at = "",
    this.description = "",
    this.notification_type = "",
    this.target_id = "",
  });

  void setAlarm(String title, String time, String content, String notification_type, String target_id) {
    this.title = title;
    this.created_at = time;
    this.description = content;
    this.notification_type = notification_type;
    this.target_id = target_id;
  }

  factory AlarmDto.fromJson(Map<String, dynamic> json) => _$AlarmDtoFromJson(json);

  Map toJson() => _$AlarmDtoToJson(this);
}

@JsonSerializable()
class AlarmListDto {
  List<AlarmDto> list;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int totalCount;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int totalPage;
  @JsonKey(name: 'is_last', includeIfNull: true)
  bool isLast = true;

  AlarmListDto({required this.totalCount, required this.totalPage, this.isLast = true, required this.list});

  factory AlarmListDto.fromJson(Map<String, dynamic> json) => _$AlarmListDtoFromJson(json);
}
