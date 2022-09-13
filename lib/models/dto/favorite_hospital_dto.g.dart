// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_hospital_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteHospitalDto _$FavoriteHospitalDtoFromJson(Map<String, dynamic> json) =>
    FavoriteHospitalDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      name: json['name'] as String? ?? "",
      address: json['address'] as String? ?? "",
      detail_address: json['detail_address'] as String? ?? "",
      image: json['image'] as String? ?? "",
    );

Map<String, dynamic> _$FavoriteHospitalDtoToJson(
        FavoriteHospitalDto instance) =>
    <String, dynamic>{
      'id': toJsonInt(instance.id),
      'name': instance.name,
      'address': instance.address,
      'detail_address': instance.detail_address,
      'image': instance.image,
    };

FavoriteHospitalListDto _$FavoriteHospitalListDtoFromJson(
        Map<String, dynamic> json) =>
    FavoriteHospitalListDto(
      totalCount: fromJsonInt(json['totalCount']),
      totalPage: fromJsonInt(json['totalPage']),
      isLast: json['is_last'] as bool? ?? true,
      list: (json['list'] as List<dynamic>)
          .map((e) => FavoriteHospitalDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteHospitalListDtoToJson(
        FavoriteHospitalListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'totalCount': toJsonInt(instance.totalCount),
      'totalPage': toJsonInt(instance.totalPage),
      'is_last': instance.isLast,
    };
