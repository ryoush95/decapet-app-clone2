import 'dart:io';

import 'package:decapet/models/res/alarm_list_res_model.dart';
import 'package:decapet/models/res/api_res_model.dart';
import 'package:decapet/models/res/app_info1_res_model.dart';
import 'package:decapet/models/res/app_info_res_model.dart';
import 'package:decapet/models/res/br_res_model.dart';
import 'package:decapet/models/res/bt_res_model.dart';
import 'package:decapet/models/res/cert_res_model.dart';
import 'package:decapet/models/res/chart_detail_res_model.dart';
import 'package:decapet/models/res/chart_list_res_model.dart';
import 'package:decapet/models/res/common_res_model.dart';
import 'package:decapet/models/res/drug_list_res_model.dart';
import 'package:decapet/models/res/hospital_equipment_res_model.dart';
import 'package:decapet/models/res/hospital_list_res_model.dart';
import 'package:decapet/models/res/hospital_service_res_model.dart';
import 'package:decapet/models/res/inoculation_res_model.dart';
import 'package:decapet/models/res/intent_guide_res_model.dart';
import 'package:decapet/models/res/pet_img_res_model.dart';
import 'package:decapet/models/res/pet_list_res_model.dart';
import 'package:decapet/models/res/point_res_model.dart';
import 'package:decapet/models/res/reservation_res_model.dart';
import 'package:decapet/models/res/review_info_res_model.dart';
import 'package:decapet/models/res/review_res_model.dart';
import 'package:decapet/models/res/schedules_res_model.dart';
import 'package:decapet/models/res/string_list_res_model.dart';
import 'package:decapet/models/res/upload_res_model.dart';
import 'package:decapet/models/res/user_res_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'global.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: API_BASE_URL)
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @POST("/api/User/signup")
  Future<UserResModel> signUp(
    @Field("email") String email,
    @Field("password") String password,
    @Field("name") String name,
    @Field("birthday") String birthday,
    @Field("phone") String phone,
    @Field("join_path") String join_path,
    @Field("recommend_email") String recommend_email,
    @Field("zip_code") String zip_code,
    @Field("address") String address,
    @Field("address_detail") String address_detail,
    @Field("dev_type") String dev_type,
    @Field("dev_token") String dev_token,
    @Field("signup_type") String signup_type,
  );

  @POST("/api/User/id_check")
  Future<UserResModel> idCheck(
     @Field("email") String email,
  );

  @POST("/api/User/path_list")
  Future<StringListResModel> pathList();

  @POST("/api/User/login")
  Future<UserResModel> login(
    @Field("email") String email,
    @Field("pwd") String pwd,
    @Field("dev_type") String dev_type,
    @Field("dev_token") String dev_token,
    @Field("signup_type") String signup_type,
  );

  @POST("/api/User/request_cert_key")
  Future<ApiResModel> request_cert_key(@Field("phone") String phone, @Field("name") String name, @Field("email") String email);

  @POST("/api/User/check_cert_key")
  Future<CertResModel> check_cert_key(@Field("phone") String phone, @Field("cert_key") String cert_key);

  @POST("/api/User/change_password")
  Future<ApiResModel> change_password(@Field("email") String email, @Field("new_password") String new_pwd);

  @POST("/api/Home/personality_list")
  Future<StringListResModel> personality_list(
    @Field("access_token") String access_token,
  );

  @POST("/api/Home/pet_list")
  Future<PetListResModel> pet_list(@Field("access_token") String access_token);

  @POST("/api/Home/hospital_list")
  Future<HospitalListResModel> hospital_list(
    @Field("access_token") String access_token,
    @Field("page") int page,
    @Field("order") String order,
    @Field("keyword") String keyword,
    @Field("region") String region,
    @Field("sphere") String sphere,
    @Field("my_latitude") String my_latitude,
    @Field("my_longitude") String my_longitude,
    @Field("speciality") String speciality,
    @Field("reserve_yn") String reserve_yn,
    @Field("reservation_type") String reservation_type,
  );

  @POST("/api/Home/hospital_services")
  Future<HospitalServiceResModel> hospital_services(
    @Field("access_token") String access_token,
    @Field("hospital_id") int hospital_id,
  );

  @POST("/api/Home/hospital_equipments")
  Future<HospitalEquipmentResModel> hospital_equipments(
    @Field("access_token") String access_token,
    @Field("hospital_id") int hospital_id,
  );

  @POST("/api/Upload/upload_file")
  @MultiPart()
  Future<UploadResModel> uploadFiles(
    @Part(name: "access_token") String access_token,
    @Part(name: "upload_files[]") List<File> upload_files,
  );

  @POST("/api/Home/upload_pet")
  @MultiPart()
  Future<PetImageResModel> uploadPetImage(
    @Part(name: "access_token") String access_token,
    @Part(name: "pet_id") int pet_id,
    @Part(name: "upload_file") File upload_file,
    @Part(name: "type") int type,
  );

  @POST("/api/Home/get_breeds")
  Future<StringListResModel> breed_list(
    @Field("access_token") String access_token,
    @Field("animal_type") String animal_type,
  );

  @POST("/api/Home/register_pet")
  Future<ApiResModel> register_pet(
    @Field("access_token") String access_token,
    @Field("registration_number") String registration_number,
    @Field("registration_image") String registration_image,
    @Field("animal_type") String animal_type,
    @Field("breed") String breed,
    @Field("gender") String gender,
    @Field("neutering_status") String neutering_status,
    @Field("personality") String personality,
    @Field("disease") String disease,
    @Field("wish") String wish,
    @Field("pet_id") int pet_id,
    @Field("birth") String birth,
    @Field("name") String name,
  );

  @POST("/api/User/change_profile")
  Future<UserResModel> changeProfile(
    @Field("access_token") String access_token,
    @Field("email") String email,
    @Field("password") String password,
    @Field("name") String name,
    @Field("birthday") String birthday,
    @Field("phone") String phone,
    @Field("zip_code") String zipCode,
    @Field("address") String address,
    @Field("address_detail") String address_detail,
    @Field("join_path") String join_path,
    @Field("recommend_email") String recommend_email,
  );

  @POST("/api/Home/drug_list")
  Future<DrugListResModel> drug_list();

  @POST("/api/Home/drug_list")
  Future<DrugListResModel> drug_list1(@Field("access_token") String access_token, @Field("animal_type") String animal_type, @Field("drug_type") String drug_type, @Field("pet_id") int pet_id);

  @POST("/api/Home/add_inoculation")
  Future<ApiResModel> add_inoculation(@Field("access_token") String access_token, @Field("pet_id") int pet_id, @Field("type") String type, @Field("inoculation_date") String inoculation_date, @Field("drug_id") int drug_id);

  @POST("/api/User/signout")
  Future<ApiResModel> signout(
    @Field("access_token") String access_token,
  );

  @POST("/api/Mypage/point_history")
  Future<PointListResModel> pointHistory(
    @Field("access_token") String access_token,
    @Field("page") int page,
  );

  @POST("/api/App/app_info")
  Future<AppInfoResModel> appInfo(
    @Field("access_token") String access_token,
  );

  @POST("/api/App/intent_guide")
  Future<IntentGuideResModel> intent_guide(
    @Field("access_token") String access_token,
    @Field("type") String type,
  );

  @POST("/api/Mypage/my_favourite_list")
  Future<HospitalListResModel> favoriteHospitalList(
    @Field("access_token") String access_token,
    @Field("page") int page,
  );

  @POST("/api/Mypage/set_favourite")
  Future<ApiResModel> setFavorite(
    @Field("access_token") String access_token,
    @Field("hospital_id") int hospital_id,
    @Field("is_set") String is_set,
  );

  @POST("/api/Review/like_review")
  Future<ApiResModel> likeReview(
    @Field("access_token") String access_token,
    @Field("review_id") int review_id,
    @Field("is_set") String is_set,
  );

  @POST("/api/Mypage/alarm_setting")
  Future<ApiResModel> alarmSetting(
    @Field("access_token") String access_token,
    @Field("alarm_yn") String alarm_yn,
    @Field("receive_other") String receive_other,
  );

  @POST("/api/App/alarm_list")
  Future<AlarmListResModel> alarm_list(
    @Field("access_token") String access_token,
    @Field("page") int page,
  );

  @POST("/api/App/read_alarm")
  Future<ApiResModel> read_alarm(
    @Field("access_token") String access_token,
    @Field("alarm_uid") int alarm_uid,
  );

  @POST("/api/Review/feeling_list")
  Future<StringListResModel> feeling_list(
    @Field("access_token") String access_token,
  );

  @POST("/api/Review/review_write")
  Future<ApiResModel> review_write(
    @Field("access_token") String access_token,
    @Field("medical_record_id") int medical_record_id,
    @Field("purpose") String purpose,
    @Field("feelings") String feelings,
    @Field("receipt_image") String receipt_image,
    @Field("review_images") String review_images,
    @Field("description") String description,
    @Field("hospital_id") int hospital_id,
    @Field("review_id") int review_id,
  );

  @POST("/api/Home/bt_items")
  Future<BtResModel> getBtItems(
    @Field("access_token") String access_token,
  );

  @POST("/api/Home/bt_sub_items")
  Future<BtResModel> btSubItems(
    @Field("access_token") String access_token,
  );

  @POST("/api/Home/blood_test_result")
  Future<BRResModel> btResult(
    @Field("access_token") String access_token,
    @Field("pet_id") int pet_id,
    @Field("date") String date,
  );

  @POST("/api/Home/bt_result_all")
  Future<BRResModel> btResultAll(
    @Field("access_token") String access_token,
    @Field("pet_id") int pet_id,
  );

  // @POST("/api/Home/bt_items")
  // Future<BtResultResModel> btItems(
  //   @Field("access_token") String access_token,
  // );

  @POST("/api/Home/region_sphere")
  Future<StringListResModel> regionSphere(
    @Field("access_token") String access_token,
    @Field("region") String region,
  );

  @POST("/api/Mypage/reservation_history")
  Future<ReservationListResModel> reservation_history(
    @Field("access_token") String access_token,
    @Field("is_past") String is_past,
    @Field("page") int page,
  );

  @POST("/api/Chart/add_chart")
  Future<ApiResModel> add_chart(
    @Field("access_token") String access_token,
    @Field("is_sick") String is_sick,
    @Field("symptoms") String symptoms,
    @Field("hospital_id") int hospital_id,
    @Field("veterinarian") String veterinarian,
    @Field("vet_registration_number") String vet_registration_number,
    @Field("description") String description,
    @Field("prescription") String prescription,
    @Field("writer") int writer,
    @Field("pet_id") int pet_id,
    @Field("disease") String disease,
  );

  @POST("/api/Chart/chart_list")
  Future<ChartListResModel> chart_list(
    @Field("access_token") String access_token,
    @Field("pet_id") int pet_id,
    @Field("page") int page,
  );

  @POST("/api/Chart/symptom_list")
  Future<StringListResModel> symptom_list(
    @Field("access_token") String access_token,
  );

  @POST("/api/Mypage/check_reservation")
  Future<ReservationResModel> check_reservation(
    @Field("access_token") String access_token,
    @Field("reservation_id") int reservation_id,
  );

  @POST("/api/Review/available_list")
  Future<ChartListResModel> available_list(
    @Field("access_token") String access_token,
    @Field("page") int page,
  );

  @POST("/api/Chart/view_chart")
  Future<ChartDetailResModel> view_chart(
    @Field("access_token") String access_token,
    @Field("id") int id,
  );

  @POST("/api/Review/check_review")
  Future<ReviewResModel> check_review(
    @Field("access_token") String access_token,
    @Field("review_id") int review_id,
    @Field("medical_id") int medical_record_id,
  );

  @POST("/api/Home/make_blood_test")
  Future<CommonResModel> makeBloodTest(
    @Field("access_token") String access_token,
    @Field("bt_items") String bt_items,
    @Field("hospital_id") int hospital_id,
    @Field("reserve_dt") String reserve_dt,
    @Field("pay_method") String pay_method,
    @Field("list_price") int list_price,
    @Field("point") int point,
    @Field("phone_number") String phone_number,
    @Field("email") String email,
    @Field("pet_id") int pet_id,
    @Field("accident_yn") String accident_yn,
    @Field("reservation_id") int reservation_id,
  );

  @POST("/api/Pay/cancel_reservation")
  Future<ApiResModel> cancelReservation(
    @Field("access_token") String access_token,
    @Field("reservation_id") int reservation_id,
  );

  @POST("/api/Review/recent_review_list")
  Future<ReviewListResModel> recent_review_list(
    @Field("access_token") String access_token,
  );

  @POST("/api/Review/review_list")
  Future<ReviewListResModel> review_list(
    @Field("access_token") String access_token,
    @Field("page") int page,
    @Field("hospital_id") int hospital_id,
    @Field("keyword") String keyword,
    @Field("purpose") String purpose,
    @Field("order") String order,
    @Field("user_id") int user_id,
  );

  @POST("/api/Review/review_delete")
  Future<ApiResModel> review_delete(
    @Field("access_token") String access_token,
    @Field("review_id") int review_id,
  );

  @POST("/api/Review/review_info")
  Future<ReviewInfoResModel> review_info(
    @Field("access_token") String access_token,
    @Field("hospital_id") int hospital_id,
  );

  @POST("/api/Home/view_inoculation")
  Future<InoculationResModel> view_inoculation(
    @Field("access_token") String access_token,
    @Field("type") String type,
    @Field("pet_id") int pet_id,
  );

  @POST("/api/Pay/start")
  Future<ApiResModel> payStart(
    @Field("access_token") String access_token,
    @Field("pet_id") int pet_id,
    @Field("hospital_id") int hospital_id,
    @Field("point") int point,
    @Field("merchant_uid") String merchant_uid,
    @Field("list_price") int list_price,
    @Field("bt_items") String bt_items,
    @Field("reserve_dt") String reserve_dt,
  );

  @POST("/api/Pay/app_info")
  Future<AppInfo1ResModel> appStartInfo(
    @Field("dev_type") String dev_type,
  );

  @POST("/api/Home/hospital_sch_info")
  Future<SchedulesResModel> hosiptalSchInfo(
    @Field("access_token") String access_token,
    @Field("hospital_id") int hospital_id,
  );
}
