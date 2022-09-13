// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cert_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertResModel _$CertResModelFromJson(Map<String, dynamic> json) => CertResModel(
      data: json['data'] == null
          ? null
          : CertDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$CertResModelToJson(CertResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
