import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reviewmanagementitem_dto.g.dart';

@JsonSerializable()
class ReviewManagementItemDto {
  String path;
  String title;
  String name;

  ReviewManagementItemDto({
    this.path = "",
    this.title = "",
    this.name = "",
  });

  factory ReviewManagementItemDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewManagementItemDtoFromJson(json);

  Map toJson() => _$ReviewManagementItemDtoToJson(this);
}
