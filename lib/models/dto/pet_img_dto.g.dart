// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_img_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetImageDto _$PetImageDtoFromJson(Map<String, dynamic> json) => PetImageDto(
      id: json['id'] as String,
      pet_image: json['pet_image'] as String,
      registration_image: json['registration_image'] as String,
    );

Map<String, dynamic> _$PetImageDtoToJson(PetImageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pet_image': instance.pet_image,
      'registration_image': instance.registration_image,
    };
