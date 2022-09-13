import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_info_dto.g.dart';

@JsonSerializable()
class ReviewInfoDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int total_user_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int reviewer_cnt;
  String feeling_percents;
  String purpose_cnts;

  ReviewInfoDto({
    this.total_user_cnt = 0,
    this.reviewer_cnt = 0,
    this.feeling_percents = "",
    this.purpose_cnts = "",
  });

  factory ReviewInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewInfoDtoFromJson(json);

  Map toJson() => _$ReviewInfoDtoToJson(this);
}