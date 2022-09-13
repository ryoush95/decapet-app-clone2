// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartDto _$ChartDtoFromJson(Map<String, dynamic> json) => ChartDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      pet_id: json['pet_id'] == null ? 0 : fromJsonInt(json['pet_id']),
      date: json['date'] as String? ?? "",
      hospital_name: json['hospital_name'] as String? ?? "",
      type: json['type'] as String? ?? "",
      disease: json['disease'] as String? ?? "",
      status: json['status'] as String? ?? "",
      visit_dt: json['visit_dt'] as String? ?? "",
      veterinarian: json['veterinarian'] as String? ?? "",
      vet_registration_number: json['vet_registration_number'] as String? ?? "",
      symptoms: json['symptoms'] as String? ?? "",
      description: json['description'] as String? ?? "",
      prescription: json['prescription'] as String? ?? "",
      hospital_id:
          json['hospital_id'] == null ? 0 : fromJsonInt(json['hospital_id']),
    );

Map<String, dynamic> _$ChartDtoToJson(ChartDto instance) => <String, dynamic>{
      'id': toJsonInt(instance.id),
      'pet_id': toJsonInt(instance.pet_id),
      'date': instance.date,
      'hospital_id': toJsonInt(instance.hospital_id),
      'hospital_name': instance.hospital_name,
      'type': instance.type,
      'disease': instance.disease,
      'status': instance.status,
      'visit_dt': instance.visit_dt,
      'veterinarian': instance.veterinarian,
      'vet_registration_number': instance.vet_registration_number,
      'symptoms': instance.symptoms,
      'description': instance.description,
      'prescription': instance.prescription,
    };

ChartListDto _$ChartListDtoFromJson(Map<String, dynamic> json) => ChartListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => ChartDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: fromJsonInt(json['total_count']),
      totalPage: fromJsonInt(json['total_page']),
      isLast: json['is_last'] as bool,
    );

Map<String, dynamic> _$ChartListDtoToJson(ChartListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total_count': toJsonInt(instance.totalCount),
      'total_page': toJsonInt(instance.totalPage),
      'is_last': instance.isLast,
    };
