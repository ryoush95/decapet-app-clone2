import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bt_result_item_dto.g.dart';

@JsonSerializable()
class BtResultItemDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  String name;
  String unit;
  String value;
  String refer_max;
  String refer_min;

  BtResultItemDto({
    this.id = 0,
    this.name = "",
    this.unit = "",
    this.value = "",
    this.refer_max = "",
    this.refer_min = "",
  });

  factory BtResultItemDto.fromJson(Map<String, dynamic> json) =>
      _$BtResultItemDtoFromJson(json);

  Map toJson() => _$BtResultItemDtoToJson(this);
}

@JsonSerializable()
class BtResultListDto {
  List<BtResultItemDto> list;

  BtResultListDto({required this.list}) : super();

  factory BtResultListDto.fromJson(Map<String, dynamic> json) =>
      _$BtResultListDtoFromJson(json);
}