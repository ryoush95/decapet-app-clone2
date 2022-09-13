// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_hospital_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteHospitalResModel _$FavoriteHospitalResModelFromJson(
        Map<String, dynamic> json) =>
    FavoriteHospitalResModel(
      data: json['data'] == null
          ? null
          : FavoriteHospitalListDto.fromJson(
              json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$FavoriteHospitalResModelToJson(
        FavoriteHospitalResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
