// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_hospital_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeHospitalItemDto _$HomeHospitalItemDtoFromJson(Map<String, dynamic> json) =>
    HomeHospitalItemDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      address_detail: json['address_detail'] as String? ?? '',
      phone_number: json['phone_number'] as String? ?? '',
      review_date: json['review_date'] as String? ?? '',
      image: json['image'] as String? ?? '',
      like_yn: json['like_yn'] as String? ?? 'n',
      review_cnt:
          json['review_cnt'] == null ? 0 : fromJsonInt(json['review_cnt']),
      like_cnt: json['like_cnt'] == null ? 0 : fromJsonInt(json['like_cnt']),
    );

Map<String, dynamic> _$HomeHospitalItemDtoToJson(
        HomeHospitalItemDto instance) =>
    <String, dynamic>{
      'id': toJsonInt(instance.id),
      'name': instance.name,
      'address': instance.address,
      'address_detail': instance.address_detail,
      'phone_number': instance.phone_number,
      'image': instance.image,
      'review_date': instance.review_date,
      'like_yn': instance.like_yn,
      'review_cnt': toJsonInt(instance.review_cnt),
      'like_cnt': toJsonInt(instance.like_cnt),
    };

HomeHospitalListDto _$HomeHospitalListDtoFromJson(Map<String, dynamic> json) =>
    HomeHospitalListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => HomeHospitalItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeHospitalListDtoToJson(
        HomeHospitalListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
