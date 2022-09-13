import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_pet_item_dto.g.dart';

@JsonSerializable()
class PetDto {
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int id;
  String level;
  String name;
  String identy_number;
  String pet_image;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int age;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int bt_dd;
  String bt_dt;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int bt_percent;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int rabies_dd;
  String rabies_dt;
  String rabies_created_at;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int rabies_percent;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int heartworm_dd;
  String heartworm_dt;
  String heartworm_created_at;
  String heartworm_drug_name;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int heartworm_drug_id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int heartworm_percent;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int ecto_dd;
  String ecto_dt;
  String ecto_created_at;
  String ecto_drug_name;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int ecto_drug_id;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int ecto_percent;

  String registration_image;
  String registration_number;
  String animal_type;
  String gender;
  String birth;
  String unique_number;
  String bt_created_at;

  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int reservation_cnt;

  PetDto(
      {this.id = 0,
      this.level = '',
      this.name = '',
      this.identy_number = '',
      this.pet_image = '',
      this.age = 0,
      this.bt_dd = 0,
      this.bt_dt = "",
      this.bt_percent = 0,
      this.rabies_dd = 0,
      this.rabies_dt = "",
      this.rabies_created_at = "",
      this.rabies_percent = 0,
      this.heartworm_dd = 0,
      this.heartworm_dt = "",
      this.heartworm_created_at = "",
      this.heartworm_drug_name = "",
      this.heartworm_drug_id = 0,
      this.heartworm_percent = 0,
      this.ecto_dd = 0,
      this.ecto_dt = "",
      this.ecto_created_at = "",
      this.ecto_drug_name = "",
      this.ecto_drug_id = 0,
      this.ecto_percent = 0,
      this.registration_image = '',
      this.registration_number = '',
      this.animal_type = 'cat',
      this.gender = '',
      this.birth = '',
      this.bt_created_at = '',
      this.reservation_cnt = 0,
      this.unique_number = ''});

  factory PetDto.fromJson(Map<String, dynamic> json) => _$PetDtoFromJson(json);

  Map toJson() => _$PetDtoToJson(this);
}

@JsonSerializable()
class PetListDto {
  List<PetDto> list;
  bool isLast = true;
  String guide;

  PetListDto({required this.list, required this.guide}) : super();

  factory PetListDto.fromJson(Map<String, dynamic> json) => _$PetListDtoFromJson(json);
}
