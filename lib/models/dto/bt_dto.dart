import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bt_dto.g.dart';

@JsonSerializable()
class BtDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  String item_type;
  String type;
  String name;
  String detail;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int price;
  String reference_min;
  String reference_max;
  String unit;

  BtDto({
    this.id = 0,
    this.name = "",
    this.item_type = "",
    this.type = "",
    this.detail = "",
    this.price = 0,
    this.reference_min = "",
    this.reference_max = "",
    this.unit = "",
  });

  factory BtDto.fromJson(Map<String, dynamic> json) => _$BtDtoFromJson(json);

  Map toJson() => _$BtDtoToJson(this);
}

@JsonSerializable()
class BtListDto {
  List<BtDto> list;
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

  BtListDto({required this.list, required this.cbc_cnt, required this.sdma_cnt, required this.electro_cnt, required this.pro_cnt, required this.serum_cnt}) : super();

  factory BtListDto.fromJson(Map<String, dynamic> json) => _$BtListDtoFromJson(json);
}
