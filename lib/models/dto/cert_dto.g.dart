// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cert_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertDto _$CertDtoFromJson(Map<String, dynamic> json) => CertDto(
      email: json['email'] as String? ?? "",
      signupType: json['signupType'] as String? ?? "",
    );

Map<String, dynamic> _$CertDtoToJson(CertDto instance) => <String, dynamic>{
      'email': instance.email,
      'signupType': instance.signupType,
    };
