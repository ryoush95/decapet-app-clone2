import 'package:json_annotation/json_annotation.dart';

part 'pet_img_dto.g.dart';

@JsonSerializable()
class PetImageDto {
  String id;
  String pet_image;
  String registration_image;

  PetImageDto({required this.id, required this.pet_image, required this.registration_image}) : super();

  factory PetImageDto.fromJson(Map<String, dynamic> json) => _$PetImageDtoFromJson(json);
}
