import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_dto.g.dart';

@JsonSerializable()
class ReservationDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  String name;
  String address;
  String address_detail;
  String reserve_dt;
  String bt_items;
  String bt_items_text;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int list_price;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int price;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int point;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int pet_id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int hospital_id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int diff_days;
  String pay_method;
  String image;
  String pay_status;
  String pay_cancelled_at;

  ReservationDto({
    this.id = 0,
    this.pet_id = 0,
    this.hospital_id = 0,
    this.diff_days = 0,
    this.name = "",
    this.address = "",
    this.address_detail = "",
    this.reserve_dt = "2022-04-21 11:00",
    this.bt_items = "",
    this.bt_items_text = "",
    this.list_price = 0,
    this.price = 0,
    this.point = 0,
    this.pay_method = "",
    this.image = "",
    this.pay_status = "",
    this.pay_cancelled_at = "",
  });

  factory ReservationDto.fromJson(Map<String, dynamic> json) => _$ReservationDtoFromJson(json);

  Map toJson() => _$ReservationDtoToJson(this);
}

@JsonSerializable()
class ReservationListDto {
  List<ReservationDto> list;
  @JsonKey(name: 'total_count', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalCount;
  @JsonKey(name: 'total_page', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalPage;
  @JsonKey(name: 'is_last', includeIfNull: true)
  bool isLast = true;

  ReservationListDto({required this.list, required this.totalCount, required this.totalPage, required this.isLast}) : super();

  factory ReservationListDto.fromJson(Map<String, dynamic> json) => _$ReservationListDtoFromJson(json);
}
