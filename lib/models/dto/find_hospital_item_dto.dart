import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'find_hospital_item_dto.g.dart';

@JsonSerializable()
class FindHospitalItemDto {
  String title;
  String content_1;
  String content_2;
  String fav_num;
  String review_num;
  String distance;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int type;

  FindHospitalItemDto({
    required this.title,
    required this.content_1,
    required this.content_2,
    required this.type,
    required this.fav_num,
    required this.review_num,
    required this.distance,
  });

}
