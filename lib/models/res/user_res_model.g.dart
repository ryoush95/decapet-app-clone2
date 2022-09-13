// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResModel _$UserResModelFromJson(Map<String, dynamic> json) => UserResModel(
      data: json['data'] == null
          ? null
          : UserDto.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..result = json['result'] as int?
      ..msg = json['msg'] as String?
      ..reason = json['reason'] as String?;

Map<String, dynamic> _$UserResModelToJson(UserResModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msg': instance.msg,
      'reason': instance.reason,
      'data': instance.data,
    };
