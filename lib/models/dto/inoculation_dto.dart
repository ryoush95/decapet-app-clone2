import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inoculation_dto.g.dart';

@JsonSerializable()
class InoculationDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int drug_id;
  String drug_name;
  String inoculation_date;

  InoculationDto({
    this.drug_id = 0,
    this.drug_name = "",
    this.inoculation_date = "",
  });

  factory InoculationDto.fromJson(Map<String, dynamic> json) =>
      _$InoculationDtoFromJson(json);

  Map toJson() => _$InoculationDtoToJson(this);
}