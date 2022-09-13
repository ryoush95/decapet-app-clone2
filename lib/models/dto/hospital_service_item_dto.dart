import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hospital_service_item_dto.g.dart';

@JsonSerializable()
class HospitalServiceItemDto {
  String name;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int price;

  HospitalServiceItemDto({
    this.name = "",
    this.price = 0,
  });

  factory HospitalServiceItemDto.fromJson(Map<String, dynamic> json) =>
      _$HospitalServiceItemDtoFromJson(json);

  Map toJson() => _$HospitalServiceItemDtoToJson(this);
}

@JsonSerializable()
class HospitalServiceListDto {
  List<HospitalServiceItemDto> list;

  HospitalServiceListDto(
      {required this.list});

  factory HospitalServiceListDto.fromJson(Map<String, dynamic> json) =>
      _$HospitalServiceListDtoFromJson(json);
}
