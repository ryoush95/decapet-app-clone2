import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_dto.g.dart';

@JsonSerializable()
class PointDto {
  String type;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int target_id;
  String created_at;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int point;

  PointDto({
    this.type = "",
    this.target_id = 0,
    this.created_at = "",
    this.point = 0,
  });

  factory PointDto.fromJson(Map<String, dynamic> json) =>
      _$PointDtoFromJson(json);

  Map toJson() => _$PointDtoToJson(this);
}

@JsonSerializable()
class PointListDto {
  List<PointDto> list;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int totalCount;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int totalPage;
  @JsonKey(name: 'is_last', includeIfNull: true)
  bool isLast = true;

  PointListDto(
      {
        required this.totalCount,
        required this.totalPage,
        this.isLast = true,
        required this.list});

  factory PointListDto.fromJson(Map<String, dynamic> json) =>
      _$PointListDtoFromJson(json);
}
