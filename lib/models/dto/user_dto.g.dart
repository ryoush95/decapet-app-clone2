// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      access_token: json['access_token'] as String? ?? "",
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      email: json['email'] as String? ?? "",
      password_digest: json['password_digest'] as String? ?? "",
      pwd: json['pwd'] as String? ?? "",
      name: json['name'] as String? ?? "",
      phone_number: json['phone_number'] as String? ?? "",
      zip_code: json['zip_code'] as String? ?? "",
      address: json['address'] as String? ?? "",
      birthday: json['birthday'] as String? ?? "",
      address_detail: json['address_detail'] as String? ?? "",
      my_point: json['my_point'] == null ? 0 : fromJsonInt(json['my_point']),
      path: json['path'] as String? ?? "",
      recommend_email: json['recommend_email'] as String? ?? "",
      pet_cnt: json['pet_cnt'] == null ? 0 : fromJsonInt(json['pet_cnt']),
      reservation_cnt: json['reservation_cnt'] == null
          ? 0
          : fromJsonInt(json['reservation_cnt']),
      reserve_past_cnt: json['reserve_past_cnt'] == null
          ? 0
          : fromJsonInt(json['reserve_past_cnt']),
      alarm_cnt: json['alarm_cnt'] == null ? 0 : fromJsonInt(json['alarm_cnt']),
      alarm_yn: json['alarm_yn'] as String? ?? "",
      receive_other: json['receive_other'] as String? ?? "",
      dev_type: json['dev_type'] as String? ?? "",
      dev_token: json['dev_token'] as String? ?? "",
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'id': toJsonInt(instance.id),
      'email': instance.email,
      'password_digest': instance.password_digest,
      'pwd': instance.pwd,
      'name': instance.name,
      'phone_number': instance.phone_number,
      'birthday': instance.birthday,
      'zip_code': instance.zip_code,
      'address': instance.address,
      'address_detail': instance.address_detail,
      'alarm_yn': instance.alarm_yn,
      'receive_other': instance.receive_other,
      'my_point': toJsonInt(instance.my_point),
      'path': instance.path,
      'recommend_email': instance.recommend_email,
      'pet_cnt': toJsonInt(instance.pet_cnt),
      'reservation_cnt': toJsonInt(instance.reservation_cnt),
      'reserve_past_cnt': toJsonInt(instance.reserve_past_cnt),
      'alarm_cnt': toJsonInt(instance.alarm_cnt),
      'dev_type': instance.dev_type,
      'dev_token': instance.dev_token,
    };
