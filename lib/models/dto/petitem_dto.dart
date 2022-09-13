import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'petitem_dto.g.dart';

@JsonSerializable()
class PetItemDto {
  String name;
  String content;

  PetItemDto({
    this.name = "",
    this.content = "",
  });

  factory PetItemDto.fromJson(Map<String, dynamic> json) =>
      _$PetItemDtoFromJson(json);

  Map toJson() => _$PetItemDtoToJson(this);
}
