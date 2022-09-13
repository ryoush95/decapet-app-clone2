import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favoritehospitalitem_dto.g.dart';

@JsonSerializable()
class FavoriteHospitalItemDto {
  String path;
  String name;
  String address;

  FavoriteHospitalItemDto({
    this.path = "",
    this.name = "",
    this.address = "",
  });

  factory FavoriteHospitalItemDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteHospitalItemDtoFromJson(json);

  Map toJson() => _$FavoriteHospitalItemDtoToJson(this);
}
