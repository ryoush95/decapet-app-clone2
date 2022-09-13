import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treatment_chart_item_dto.g.dart';

@JsonSerializable()
class TreatmentChartItemDto {
  String title;
  String content_1;
  String content_2;
  String content_3;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int type;

  TreatmentChartItemDto({
    required this.title,
    required this.content_1,
    required this.content_2,
    required this.content_3,
    required this.type,
  });

}
