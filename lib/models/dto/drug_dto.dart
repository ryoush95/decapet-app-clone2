import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drug_dto.g.dart';

@JsonSerializable()
class DrugItemDto {
  // @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  String id;
  String name;
  String animal_type;
  String period;
  String drug_type;

  DrugItemDto({
    this.id = "",
    this.name = "",
    this.animal_type = "",
    this.period = "",
    this.drug_type = "",
  });

  factory DrugItemDto.fromJson(Map<String, dynamic> json) => _$DrugItemDtoFromJson(json);

  Map toJson() => _$DrugItemDtoToJson(this);
}

@JsonSerializable()
class DrugListDto {
  List<DrugItemDto> list;

  DrugListDto({required this.list}) : super();

  factory DrugListDto.fromJson(Map<String, dynamic> json) => _$DrugListDtoFromJson(json);
}
