import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reserve_animal_item_dto.g.dart';

@JsonSerializable()
class ReserveAnimalItemDto {
  String content_1;
  String content_2;
  String content_3;
  String content_4;


  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;

  ReserveAnimalItemDto({
    required this.content_1,
    required this.content_2,
    required this.content_3,
    required this.content_4,
    this.id = 0
  });

}
