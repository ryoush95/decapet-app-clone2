import 'package:json_annotation/json_annotation.dart';

part 'schedules_dto.g.dart';

@JsonSerializable()
class SchedulesDto {
  late String id;
  late String hospital_id;
  late String day_type;
  late String is_dayoff;
  late String start_time;
  late String end_time;
  late String created_at;
  late String updated_at;
  late String available;

  SchedulesDto({
    this.id = "",
    this.hospital_id = "",
    this.day_type = "",
    this.is_dayoff = "",
    this.start_time = "",
    this.end_time = "",
    this.created_at = "",
    this.updated_at = "",
    this.available = "",
  });

  // void setSchedules(String id, String hospital_id, String day_type, String is_dayoff, String start_time, String end_time, String created_at, String updated_at) {
  //   this.id = id;
  //   this.hospital_id = hospital_id;
  //   this.day_type = day_type;
  //   this.is_dayoff = is_dayoff;
  //   this.start_time = start_time;
  //   this.end_time = end_time;
  //   this.created_at = created_at;
  //   this.updated_at = updated_at;
  // }

  factory SchedulesDto.fromJson(Map<String, dynamic> json) => _$SchedulesDtoFromJson(json);

  Map toJson() => _$SchedulesDtoToJson(this);
}

@JsonSerializable()
class SchedulesListDto {
  List<SchedulesDto> list;
  List<SchedulesDto> special;

  SchedulesListDto({required this.list, required this.special}) : super();

  factory SchedulesListDto.fromJson(Map<String, dynamic> json) => _$SchedulesListDtoFromJson(json);
}
