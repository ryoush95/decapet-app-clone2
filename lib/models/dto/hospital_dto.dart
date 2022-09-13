import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hospital_dto.g.dart';

@JsonSerializable()
class HospitalDto {
  String name;
  String address;
  String image;
  String address_detail;
  String distance;
  String services;
  String like_yn;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int like_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int review_cnt;
  String speciality;
  @JsonKey(fromJson: fromJsonDouble, toJson: toJsonDouble)
  double latitude;
  @JsonKey(fromJson: fromJsonDouble, toJson: toJsonDouble)
  double longitude;
  String park_info;
  String caution;
  String phone_number;
  String type;
  String vaccination_yn;
  String treating_yn;
  String reserve_yn;
  String reservation_type;

  HospitalDto({
    this.name = "",
    this.address = "",
    this.image = "",
    this.address_detail = "",
    this.id = 0,
    this.like_cnt = 0,
    this.review_cnt = 0,
    this.distance = "",
    this.like_yn = "",
    this.services = "",
    this.speciality = "",
    this.latitude = 0,
    this.longitude = 0,
    this.park_info = "",
    this.caution = "",
    this.phone_number = "",
    this.type = "",
    this.vaccination_yn = "",
    this.treating_yn = "",
    this.reserve_yn = "",
    this.reservation_type = "",
  });

  factory HospitalDto.fromJson(Map<String, dynamic> json) => _$HospitalDtoFromJson(json);

  Map toJson() => _$HospitalDtoToJson(this);
}

@JsonSerializable()
class HospitalListDto {
  List<HospitalDto> list;
  @JsonKey(name: 'total_count', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalCount;
  @JsonKey(name: 'total_page', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalPage;
  @JsonKey(name: 'is_last', includeIfNull: true)
  bool isLast = true;
  @JsonKey(name: 'total_count_no_filter', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalCountNoFilter;

  HospitalListDto({required this.totalCount, required this.totalPage, required this.totalCountNoFilter, this.isLast = true, required this.list});

  factory HospitalListDto.fromJson(Map<String, dynamic> json) => _$HospitalListDtoFromJson(json);
}
