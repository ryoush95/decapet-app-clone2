import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hospital_equipment_item_dto.g.dart';

@JsonSerializable()
class HospitalEquipmentItemDto {
  String name;
  String description;

  HospitalEquipmentItemDto({
    this.name = "",
    this.description = "",
  });

  factory HospitalEquipmentItemDto.fromJson(Map<String, dynamic> json) =>
      _$HospitalEquipmentItemDtoFromJson(json);

  Map toJson() => _$HospitalEquipmentItemDtoToJson(this);
}

@JsonSerializable()
class HospitalEquipmentListDto {
  List<HospitalEquipmentItemDto> list;

  HospitalEquipmentListDto(
      {required this.list});

  factory HospitalEquipmentListDto.fromJson(Map<String, dynamic> json) =>
      _$HospitalEquipmentListDtoFromJson(json);
}
