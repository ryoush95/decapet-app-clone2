import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  late String access_token;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  late int id;
  late String email;
  late String password_digest;
  late String pwd;
  late String name;
  late String phone_number;
  late String birthday;
  late String zip_code;
  late String address;
  late String address_detail;
  late String alarm_yn;
  late String receive_other;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  late int my_point;
  late String path;
  late String recommend_email;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  late int pet_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  late int reservation_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  late int reserve_past_cnt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  late int alarm_cnt;
  late String dev_type;
  late String dev_token;

  UserDto({
    this.access_token = "",
    this.id = 0,
    this.email = "",
    this.password_digest = "",
    this.pwd = "",
    this.name = "",
    this.phone_number = "",
    this.zip_code = "",
    this.address = "",
    this.birthday = "",
    this.address_detail = "",
    this.my_point = 0,
    this.path = "",
    this.recommend_email = "",
    this.pet_cnt = 0,
    this.reservation_cnt = 0,
    this.reserve_past_cnt = 0,
    this.alarm_cnt = 0,
    this.alarm_yn = "",
    this.receive_other = "",
    this.dev_type = "",
    this.dev_token = "",
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
