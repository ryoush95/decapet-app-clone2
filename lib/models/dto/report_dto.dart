import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_dto.g.dart';

@JsonSerializable()
class ReportDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int report_uid;
  String morning_time;
  String morning_temperature;
  String morning_saturation;
  String morning_symptom;
  String morning_breath;
  String morning_medication;
  String afternoon_time;
  String afternoon_temperature;
  String afternoon_saturation;
  String afternoon_breath;
  String afternoon_symptom;
  String afternoon_medication;

  ReportDto({
    this.report_uid = 0,
    this.morning_time = '',
    this.morning_temperature = '',
    this.morning_saturation = '',
    this.morning_breath = '',
    this.morning_symptom = '',
    this.morning_medication = '',
    this.afternoon_time = '',
    this.afternoon_temperature = '',
    this.afternoon_saturation = '',
    this.afternoon_breath = '',
    this.afternoon_symptom = '',
    this.afternoon_medication = '',

  });

  factory ReportDto.fromJson(Map<String, dynamic> json) =>
      _$ReportDtoFromJson(json);

  Map toJson() => _$ReportDtoToJson(this);
}

@JsonSerializable()
class ReportListDto {
  List<ReportDto> list;

  ReportListDto({required this.list}) : super();

  factory ReportListDto.fromJson(Map<String, dynamic> json) =>
      _$ReportListDtoFromJson(json);
}