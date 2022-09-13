import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blood_test_result_item_dto.g.dart';

@JsonSerializable()
class BloodTestResultItemDto {
  String title;
  List <String> headers;
  List<List<String>> datas;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int row_count;

  BloodTestResultItemDto({
    required this.title,
    required this.row_count,
    required this.headers,
    required this.datas,

  });

}
