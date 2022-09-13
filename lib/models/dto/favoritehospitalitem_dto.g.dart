// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoritehospitalitem_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteHospitalItemDto _$FavoriteHospitalItemDtoFromJson(
        Map<String, dynamic> json) =>
    FavoriteHospitalItemDto(
      path: json['path'] as String? ?? "",
      name: json['name'] as String? ?? "",
      address: json['address'] as String? ?? "",
    );

Map<String, dynamic> _$FavoriteHospitalItemDtoToJson(
        FavoriteHospitalItemDto instance) =>
    <String, dynamic>{
      'path': instance.path,
      'name': instance.name,
      'address': instance.address,
    };
