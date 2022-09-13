// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDto _$ReviewDtoFromJson(Map<String, dynamic> json) => ReviewDto(
      id: json['id'] == null ? 0 : fromJsonInt(json['id']),
      user_id: json['user_id'] == null ? 0 : fromJsonInt(json['user_id']),
      like_cnt: json['like_cnt'] == null ? 0 : fromJsonInt(json['like_cnt']),
      medical_record_id: json['medical_record_id'] == null
          ? 0
          : fromJsonInt(json['medical_record_id']),
      hospital_id:
          json['hospital_id'] == null ? 0 : fromJsonInt(json['hospital_id']),
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      receipt_image: json['receipt_image'] as String? ?? "",
      user_name: json['user_name'] as String? ?? "",
      hospital_name: json['hospital_name'] as String? ?? "",
      created_at: json['created_at'] as String? ?? "",
      purpose: json['purpose'] as String? ?? "",
      feelings: json['feelings'] as String? ?? "",
      review_images: json['review_images'] as String? ?? "",
      favourite_yn: json['favourite_yn'] as String? ?? "n",
      like_yn: json['like_yn'] as String? ?? "n",
      status: json['status'] as String? ?? "",
    );

Map<String, dynamic> _$ReviewDtoToJson(ReviewDto instance) => <String, dynamic>{
      'id': toJsonInt(instance.id),
      'user_id': toJsonInt(instance.user_id),
      'medical_record_id': toJsonInt(instance.medical_record_id),
      'hospital_id': toJsonInt(instance.hospital_id),
      'like_cnt': toJsonInt(instance.like_cnt),
      'title': instance.title,
      'description': instance.description,
      'receipt_image': instance.receipt_image,
      'purpose': instance.purpose,
      'feelings': instance.feelings,
      'created_at': instance.created_at,
      'review_images': instance.review_images,
      'favourite_yn': instance.favourite_yn,
      'status': instance.status,
      'hospital_name': instance.hospital_name,
      'user_name': instance.user_name,
      'like_yn': instance.like_yn,
    };

ReviewListDto _$ReviewListDtoFromJson(Map<String, dynamic> json) =>
    ReviewListDto(
      list: (json['list'] as List<dynamic>)
          .map((e) => ReviewDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: fromJsonInt(json['total_count']),
      totalPage: fromJsonInt(json['total_page']),
      isLast: json['is_last'] as bool,
    );

Map<String, dynamic> _$ReviewListDtoToJson(ReviewListDto instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total_count': toJsonInt(instance.totalCount),
      'total_page': toJsonInt(instance.totalPage),
      'is_last': instance.isLast,
    };
