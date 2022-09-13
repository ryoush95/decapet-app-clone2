import 'package:decapet/helpers/bind_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cert_dto.g.dart';

@JsonSerializable()
class CertDto {
  String email;
  String signupType;

  CertDto({
    this.email = "",
    this.signupType = "",
  });

  factory CertDto.fromJson(Map<String, dynamic> json) =>
      _$CertDtoFromJson(json);

  Map toJson() => _$CertDtoToJson(this);
}
