import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chart_dto.g.dart';

@JsonSerializable()
class ChartDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int pet_id;
  String date;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int hospital_id;
  String hospital_name;
  String type;
  String disease;
  String status;
  String visit_dt;
  String veterinarian;
  String vet_registration_number;
  String symptoms;
  String description;
  String prescription;


  ChartDto({
    this.id = 0,
    this.pet_id = 0,
    this.date = "",
    this.hospital_name = "",
    this.type = "",
    this.disease = "",
    this.status = "",
    this.visit_dt = "",
    this.veterinarian = "",
    this.vet_registration_number = "",
    this.symptoms = "",
    this.description = "",
    this.prescription = "",
    this.hospital_id = 0
  });

  factory ChartDto.fromJson(Map<String, dynamic> json) =>
      _$ChartDtoFromJson(json);

  Map toJson() => _$ChartDtoToJson(this);
}

@JsonSerializable()
class ChartListDto {
  List<ChartDto> list;
  @JsonKey(name: 'total_count', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalCount;
  @JsonKey(name: 'total_page', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalPage;
  @JsonKey(name: 'is_last', includeIfNull: true)
  bool isLast = true;

  ChartListDto(
      {required this.list,
        required this.totalCount,
        required this.totalPage,
        required this.isLast})
      : super();

  factory ChartListDto.fromJson(Map<String, dynamic> json) =>
      _$ChartListDtoFromJson(json);
}