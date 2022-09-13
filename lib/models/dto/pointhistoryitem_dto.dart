import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pointhistoryitem_dto.g.dart';

@JsonSerializable()
class PointHistoryItemDto {
  String title;
  String content;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int type;
  String mark;

  PointHistoryItemDto({
    this.title = "",
    this.content = "",
    this.type = 0,
    this.mark = "",
  });

  factory PointHistoryItemDto.fromJson(Map<String, dynamic> json) =>
      _$PointHistoryItemDtoFromJson(json);

  Map toJson() => _$PointHistoryItemDtoToJson(this);
}
