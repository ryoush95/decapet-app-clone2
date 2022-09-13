import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common_dto.g.dart';

@JsonSerializable()
class CommonDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int reservation_id;
  String animal_type;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int point;

  CommonDto({
    this.reservation_id = 0,
    this.animal_type = "",
    this.point = 0,
  });

  factory CommonDto.fromJson(Map<String, dynamic> json) =>
      _$CommonDtoFromJson(json);

  Map toJson() => _$CommonDtoToJson(this);
}
