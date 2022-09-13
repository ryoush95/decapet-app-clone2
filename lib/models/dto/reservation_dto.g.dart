// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationDto _$ReservationDtoFromJson(Map<String, dynamic> json) =>
    ReservationDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      pet_id: json['pet_id'] == null ? 0 : fromJsonInt(json['pet_id']),
      hospital_id:
          json['hospital_id'] == null ? 0 : fromJsonInt(json['hospital_id']),
      diff_days: json['diff_days'] == null ? 0 : fromJsonInt(json['diff_days']),
      name: json['name'] as String? ?? "",
      address: json['address'] as String? ?? "",
      address_detail: json['address_detail'] as String? ?? "",
      reserve_dt: json['reserve_dt'] as String? ?? "2022-04-21 11:00",
      bt_items: json['bt_items'] as String? ?? "",
      bt_items_text: json['bt_items_text'] as String? ?? "",
      list_price:
          json['list_price'] == null ? 0 : fromJsonInt(json['list_price']),
      price: json['price'] == null ? 0 : fromJsonInt(json['price']),
      point: json['point'] == null ? 0 : fromJsonInt(json['point']),
      pay_method: json['pay_method'] as String? ?? "",
      image: json['image'] as String? ?? "",
      pay_status: json['pay_status'] as String? ?? "",
      pay_cancelled_at: json['pay_cancelled_at'] as String? ?? "",
    );

Map<String, dynamic> _$ReservationDtoToJson(ReservationDto instance) =>
    <String, dynamic>{
      'id': toJsonInt(instance.id),
      'name': instance.name,
      'address': instance.address,
      'address_detail': instance.address_detail,
      'reserve_dt': instance.reserve_dt,
      'bt_items': instance.bt_items,
      'bt_items_text': instance.bt_items_text,
      'list_price': toJsonInt(instance.list_price),
      'price': toJsonInt(instance.price),
      'point': toJsonInt(instance.point),
      'pet_id': toJsonInt(instance.pet_id),
      'hospital_id': toJsonInt(instance.hospital_id),
      'diff_days': toJsonInt(instance.diff_days),
      'pay_method': instance.pay_method,
      'image': instance.image,
      'pay_status': instance.pay_status,
      'pay_cancelled_at': instance.pay_cancelled_at,
    };

ReservationListDto _$ReservationListDtoFromJson(Map<String, dynamic> json) =>
    ReservationListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => ReservationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: fromJsonInt(json['total_count']),
      totalPage: fromJsonInt(json['total_page']),
      isLast: json['is_last'] as bool,
    );

Map<String, dynamic> _$ReservationListDtoToJson(ReservationListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total_count': toJsonInt(instance.totalCount),
      'total_page': toJsonInt(instance.totalPage),
      'is_last': instance.isLast,
    };
