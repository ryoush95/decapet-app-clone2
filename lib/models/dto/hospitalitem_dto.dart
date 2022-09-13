import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hospitalitem_dto.g.dart';

@JsonSerializable()
class HospitalItemDto {
  String name;
  String address;
  @JsonKey(fromJson: fromJsonInt, toJson: toJsonInt)
  int likepoint;

  HospitalItemDto({
    this.name = "",
    this.address = "",
    this.likepoint = 0,
  });

}
