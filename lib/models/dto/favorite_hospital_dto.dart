import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_hospital_dto.g.dart';

@JsonSerializable()
class FavoriteHospitalDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  String name;
  String address;
  String detail_address;
  String image;

  FavoriteHospitalDto({
    this.id = 0,
    this.name = "",
    this.address = "",
    this.detail_address = "",
    this.image = "",
  });

  factory FavoriteHospitalDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteHospitalDtoFromJson(json);

  Map toJson() => _$FavoriteHospitalDtoToJson(this);
}

@JsonSerializable()
class FavoriteHospitalListDto {
  List<FavoriteHospitalDto> list;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int totalCount;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int totalPage;
  @JsonKey(name: 'is_last', includeIfNull: true)
  bool isLast = true;

  FavoriteHospitalListDto(
      {
        required this.totalCount,
        required this.totalPage,
        this.isLast = true,
        required this.list});

  factory FavoriteHospitalListDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteHospitalListDtoFromJson(json);
}
