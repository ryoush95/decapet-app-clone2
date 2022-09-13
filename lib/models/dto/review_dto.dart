import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_dto.g.dart';

@JsonSerializable()
class ReviewDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int user_id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int medical_record_id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int hospital_id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int like_cnt;
  String title;
  String description;
  String receipt_image;
  String purpose;
  String feelings;
  String created_at;
  String review_images;
  String favourite_yn;
  String status;
  String hospital_name;
  String user_name;
  String like_yn;

  ReviewDto({
    this.id = 0,
    this.user_id = 0,
    this.like_cnt = 0,
    this.medical_record_id = 0,
    this.hospital_id = 0,
    this.title = "",
    this.description = "",
    this.receipt_image = "",
    this.user_name = "",
    this.hospital_name = "",
    this.created_at = "",
    this.purpose = "",
    this.feelings = "",
    this.review_images = "",
    this.favourite_yn = "n",
    this.like_yn = "n",
    this.status = "",
  });

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);

  Map toJson() => _$ReviewDtoToJson(this);
}

@JsonSerializable()
class ReviewListDto {
  List<ReviewDto> list;
  @JsonKey(name: 'total_count', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalCount;
  @JsonKey(name: 'total_page', fromJson: fromJsonInt, toJson: toJsonInt)
  int totalPage;
  @JsonKey(name: 'is_last', includeIfNull: true)
  bool isLast = true;

  ReviewListDto(
      {required this.list,
        required this.totalCount,
        required this.totalPage,
        required this.isLast})
      : super();

  factory ReviewListDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewListDtoFromJson(json);
}

