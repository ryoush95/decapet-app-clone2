import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'br_dto.g.dart';

@JsonSerializable()
class BRDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  String name;
  String reference_min;
  String reference_max;
  String unit;
  String date;
  String value;
  String type;

  BRDto({
    this.id = 0,
    this.name = "",
    this.reference_min = "",
    this.reference_max = "",
    this.unit = "",
    this.date = "",
    this.value = "",
    this.type = "",
  });

  factory BRDto.fromJson(Map<String, dynamic> json) =>
      _$BRDtoFromJson(json);

  Map toJson() => _$BRDtoToJson(this);
}

@JsonSerializable()
class BRListDto {
  List<BRDto> list;
  String dates;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int cbc_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int serum_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int electro_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int sdma_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int pro_cnt;

  BRListDto({required this.list, required this.dates, required this.cbc_cnt, required this.sdma_cnt, required this.electro_cnt, required this.pro_cnt, required this.serum_cnt}) : super();

  factory BRListDto.fromJson(Map<String, dynamic> json) =>
      _$BRListDtoFromJson(json);
}