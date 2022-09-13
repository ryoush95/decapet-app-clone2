import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'string_list_dto.g.dart';

@JsonSerializable()
class StringListDto {
  List<String> list;

  StringListDto({required this.list}) : super();

  factory StringListDto.fromJson(Map<String, dynamic> json) =>
      _$StringListDtoFromJson(json);
}