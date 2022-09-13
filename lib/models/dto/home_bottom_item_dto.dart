import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_bottom_item_dto.g.dart';

@JsonSerializable()
class HomeBottomItemDto {
  String title;
  String content_image;
  String content_text;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int content_digit;
  int type;

  HomeBottomItemDto({
    required this.title,
    required this.content_image,
    required this.content_text,
    required this.content_digit,
    required this.type,
  });

}
