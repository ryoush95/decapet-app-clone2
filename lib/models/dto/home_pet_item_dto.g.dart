// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_pet_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetDto _$PetDtoFromJson(Map<String, dynamic> json) => PetDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      level: json['level'] as String? ?? '',
      name: json['name'] as String? ?? '',
      identy_number: json['identy_number'] as String? ?? '',
      pet_image: json['pet_image'] as String? ?? '',
      age: json['age'] == null ? 0 : fromJsonInt(json['age']),
      bt_dd: json['bt_dd'] == null ? 0 : fromJsonInt(json['bt_dd']),
      bt_dt: json['bt_dt'] as String? ?? "",
      bt_percent:
          json['bt_percent'] == null ? 0 : fromJsonInt(json['bt_percent']),
      rabies_dd: json['rabies_dd'] == null ? 0 : fromJsonInt(json['rabies_dd']),
      rabies_dt: json['rabies_dt'] as String? ?? "",
      rabies_created_at: json['rabies_created_at'] as String? ?? "",
      rabies_percent: json['rabies_percent'] == null
          ? 0
          : fromJsonInt(json['rabies_percent']),
      heartworm_dd:
          json['heartworm_dd'] == null ? 0 : fromJsonInt(json['heartworm_dd']),
      heartworm_dt: json['heartworm_dt'] as String? ?? "",
      heartworm_created_at: json['heartworm_created_at'] as String? ?? "",
      heartworm_drug_name: json['heartworm_drug_name'] as String? ?? "",
      heartworm_drug_id: json['heartworm_drug_id'] == null
          ? 0
          : fromJsonInt(json['heartworm_drug_id']),
      heartworm_percent: json['heartworm_percent'] == null
          ? 0
          : fromJsonInt(json['heartworm_percent']),
      ecto_dd: json['ecto_dd'] == null ? 0 : fromJsonInt(json['ecto_dd']),
      ecto_dt: json['ecto_dt'] as String? ?? "",
      ecto_created_at: json['ecto_created_at'] as String? ?? "",
      ecto_drug_name: json['ecto_drug_name'] as String? ?? "",
      ecto_drug_id:
          json['ecto_drug_id'] == null ? 0 : fromJsonInt(json['ecto_drug_id']),
      ecto_percent:
          json['ecto_percent'] == null ? 0 : fromJsonInt(json['ecto_percent']),
      registration_image: json['registration_image'] as String? ?? '',
      registration_number: json['registration_number'] as String? ?? '',
      animal_type: json['animal_type'] as String? ?? 'cat',
      gender: json['gender'] as String? ?? '',
      birth: json['birth'] as String? ?? '',
      bt_created_at: json['bt_created_at'] as String? ?? '',
      reservation_cnt: json['reservation_cnt'] == null
          ? 0
          : fromJsonInt(json['reservation_cnt']),
      unique_number: json['unique_number'] as String? ?? '',
    );

Map<String, dynamic> _$PetDtoToJson(PetDto instance) => <String, dynamic>{
      'id': toJsonInt(instance.id),
      'level': instance.level,
      'name': instance.name,
      'identy_number': instance.identy_number,
      'pet_image': instance.pet_image,
      'age': toJsonInt(instance.age),
      'bt_dd': toJsonInt(instance.bt_dd),
      'bt_dt': instance.bt_dt,
      'bt_percent': toJsonInt(instance.bt_percent),
      'rabies_dd': toJsonInt(instance.rabies_dd),
      'rabies_dt': instance.rabies_dt,
      'rabies_created_at': instance.rabies_created_at,
      'rabies_percent': toJsonInt(instance.rabies_percent),
      'heartworm_dd': toJsonInt(instance.heartworm_dd),
      'heartworm_dt': instance.heartworm_dt,
      'heartworm_created_at': instance.heartworm_created_at,
      'heartworm_drug_name': instance.heartworm_drug_name,
      'heartworm_drug_id': toJsonInt(instance.heartworm_drug_id),
      'heartworm_percent': toJsonInt(instance.heartworm_percent),
      'ecto_dd': toJsonInt(instance.ecto_dd),
      'ecto_dt': instance.ecto_dt,
      'ecto_created_at': instance.ecto_created_at,
      'ecto_drug_name': instance.ecto_drug_name,
      'ecto_drug_id': toJsonInt(instance.ecto_drug_id),
      'ecto_percent': toJsonInt(instance.ecto_percent),
      'registration_image': instance.registration_image,
      'registration_number': instance.registration_number,
      'animal_type': instance.animal_type,
      'gender': instance.gender,
      'birth': instance.birth,
      'unique_number': instance.unique_number,
      'bt_created_at': instance.bt_created_at,
      'reservation_cnt': toJsonInt(instance.reservation_cnt),
    };

PetListDto _$PetListDtoFromJson(Map<String, dynamic> json) => PetListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => PetDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      guide: json['guide'] as String,
    )..isLast = json['isLast'] as bool;

Map<String, dynamic> _$PetListDtoToJson(PetListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'isLast': instance.isLast,
      'guide': instance.guide,
    };
