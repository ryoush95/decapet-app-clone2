// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalDto _$HospitalDtoFromJson(Map<String, dynamic> json) => HospitalDto(
      name: json['name'] as String? ?? "",
      address: json['address'] as String? ?? "",
      image: json['image'] as String? ?? "",
      address_detail: json['address_detail'] as String? ?? "",
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      like_cnt: json['like_cnt'] == null ? 0 : fromJsonInt(json['like_cnt']),
      review_cnt:
          json['review_cnt'] == null ? 0 : fromJsonInt(json['review_cnt']),
      distance: json['distance'] as String? ?? "",
      like_yn: json['like_yn'] as String? ?? "",
      services: json['services'] as String? ?? "",
      speciality: json['speciality'] as String? ?? "",
      latitude: json['latitude'] == null ? 0 : fromJsonDouble(json['latitude']),
      longitude:
          json['longitude'] == null ? 0 : fromJsonDouble(json['longitude']),
      park_info: json['park_info'] as String? ?? "",
      caution: json['caution'] as String? ?? "",
      phone_number: json['phone_number'] as String? ?? "",
      type: json['type'] as String? ?? "",
      vaccination_yn: json['vaccination_yn'] as String? ?? "",
      treating_yn: json['treating_yn'] as String? ?? "",
      reserve_yn: json['reserve_yn'] as String? ?? "",
      reservation_type: json['reservation_type'] as String? ?? "",
    );

Map<String, dynamic> _$HospitalDtoToJson(HospitalDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'image': instance.image,
      'address_detail': instance.address_detail,
      'distance': instance.distance,
      'services': instance.services,
      'like_yn': instance.like_yn,
      'id': toJsonInt(instance.id),
      'like_cnt': toJsonInt(instance.like_cnt),
      'review_cnt': toJsonInt(instance.review_cnt),
      'speciality': instance.speciality,
      'latitude': toJsonDouble(instance.latitude),
      'longitude': toJsonDouble(instance.longitude),
      'park_info': instance.park_info,
      'caution': instance.caution,
      'phone_number': instance.phone_number,
      'type': instance.type,
      'vaccination_yn': instance.vaccination_yn,
      'treating_yn': instance.treating_yn,
      'reserve_yn': instance.reserve_yn,
      'reservation_type': instance.reservation_type,
    };

HospitalListDto _$HospitalListDtoFromJson(Map<String, dynamic> json) =>
    HospitalListDto(
      totalCount: fromJsonInt(json['total_count']),
      totalPage: fromJsonInt(json['total_page']),
      totalCountNoFilter: fromJsonInt(json['total_count_no_filter']),
      isLast: json['is_last'] as bool? ?? true,
      list: (json['list'] as List<dynamic>)
          .map((e) => HospitalDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HospitalListDtoToJson(HospitalListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total_count': toJsonInt(instance.totalCount),
      'total_page': toJsonInt(instance.totalPage),
      'is_last': instance.isLast,
      'total_count_no_filter': toJsonInt(instance.totalCountNoFilter),
    };
