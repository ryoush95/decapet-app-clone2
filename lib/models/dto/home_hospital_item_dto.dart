import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_hospital_item_dto.g.dart';

@JsonSerializable()
class HomeHospitalItemDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  String name;
  String address;
  String address_detail;
  String phone_number;
  String image;
  String review_date;
  String like_yn;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int review_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int like_cnt;

  HomeHospitalItemDto({
    this.id = 0,
    this.name = '',
    this.address = '',
    this.address_detail = '',
    this.phone_number = '',
    this.review_date = '',
    this.image = '',
    this.like_yn = 'n',
    this.review_cnt = 0,
    this.like_cnt = 0
  });

  factory HomeHospitalItemDto.fromJson(Map<String, dynamic> json) =>
      _$HomeHospitalItemDtoFromJson(json);

  Map toJson() => _$HomeHospitalItemDtoToJson(this);
}

@JsonSerializable()
class HomeHospitalListDto {
  List<HomeHospitalItemDto> list;

  HomeHospitalListDto({required this.list}) : super();

  factory HomeHospitalListDto.fromJson(Map<String, dynamic> json) =>
      _$HomeHospitalListDtoFromJson(json);
}