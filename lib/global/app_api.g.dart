// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _Api implements Api {
  _Api(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://decapet.com:3000/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserResModel> signUp(
      email,
      password,
      name,
      birthday,
      phone,
      join_path,
      recommend_email,
      zip_code,
      address,
      address_detail,
      dev_type,
      dev_token,
      signup_type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
      'name': name,
      'birthday': birthday,
      'phone': phone,
      'join_path': join_path,
      'recommend_email': recommend_email,
      'zip_code': zip_code,
      'address': address,
      'address_detail': address_detail,
      'dev_type': dev_type,
      'dev_token': dev_token,
      'signup_type': signup_type
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/User/signup',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StringListResModel> pathList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StringListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/User/path_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StringListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserResModel> login(
      email, pwd, dev_type, dev_token, signup_type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'pwd': pwd,
      'dev_type': dev_type,
      'dev_token': dev_token,
      'signup_type': signup_type
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/User/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> request_cert_key(phone, name, email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'phone': phone, 'name': name, 'email': email};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/User/request_cert_key',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CertResModel> check_cert_key(phone, cert_key) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'phone': phone, 'cert_key': cert_key};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CertResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/User/check_cert_key',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CertResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> change_password(email, new_pwd) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email, 'new_password': new_pwd};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/User/change_password',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StringListResModel> personality_list(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StringListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/personality_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StringListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PetListResModel> pet_list(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PetListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/pet_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PetListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HospitalListResModel> hospital_list(
      access_token,
      page,
      order,
      keyword,
      region,
      sphere,
      my_latitude,
      my_longitude,
      speciality,
      reserve_yn,
      reservation_type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'page': page,
      'order': order,
      'keyword': keyword,
      'region': region,
      'sphere': sphere,
      'my_latitude': my_latitude,
      'my_longitude': my_longitude,
      'speciality': speciality,
      'reserve_yn': reserve_yn,
      'reservation_type': reservation_type
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HospitalListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/hospital_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HospitalListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HospitalServiceResModel> hospital_services(
      access_token, hospital_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'hospital_id': hospital_id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HospitalServiceResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/hospital_services',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HospitalServiceResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HospitalEquipmentResModel> hospital_equipments(
      access_token, hospital_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'hospital_id': hospital_id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HospitalEquipmentResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/hospital_equipments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HospitalEquipmentResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UploadResModel> uploadFiles(access_token, upload_files) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('access_token', access_token));
    _data.files.addAll(upload_files.map((i) => MapEntry(
        'upload_files[]',
        MultipartFile.fromFileSync(
          i.path,
          filename: i.path.split(Platform.pathSeparator).last,
        ))));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UploadResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Upload/upload_file',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UploadResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PetImageResModel> uploadPetImage(
      access_token, pet_id, upload_file, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('access_token', access_token));
    _data.fields.add(MapEntry('pet_id', pet_id.toString()));
    _data.files.add(MapEntry(
        'upload_file',
        MultipartFile.fromFileSync(upload_file.path,
            filename: upload_file.path.split(Platform.pathSeparator).last)));
    _data.fields.add(MapEntry('type', type.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PetImageResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/upload_pet',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PetImageResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StringListResModel> breed_list(access_token, animal_type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'animal_type': animal_type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StringListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/get_breeds',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StringListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> register_pet(
      access_token,
      registration_number,
      registration_image,
      animal_type,
      breed,
      gender,
      neutering_status,
      personality,
      disease,
      wish,
      pet_id,
      birth,
      name) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'registration_number': registration_number,
      'registration_image': registration_image,
      'animal_type': animal_type,
      'breed': breed,
      'gender': gender,
      'neutering_status': neutering_status,
      'personality': personality,
      'disease': disease,
      'wish': wish,
      'pet_id': pet_id,
      'birth': birth,
      'name': name
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/register_pet',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserResModel> changeProfile(
      access_token,
      email,
      password,
      name,
      birthday,
      phone,
      zipCode,
      address,
      address_detail,
      join_path,
      recommend_email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'email': email,
      'password': password,
      'name': name,
      'birthday': birthday,
      'phone': phone,
      'zip_code': zipCode,
      'address': address,
      'address_detail': address_detail,
      'join_path': join_path,
      'recommend_email': recommend_email
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/User/change_profile',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DrugListResModel> drug_list() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DrugListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/drug_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DrugListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DrugListResModel> drug_list1(
      access_token, animal_type, drug_type, pet_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'animal_type': animal_type,
      'drug_type': drug_type,
      'pet_id': pet_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DrugListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/drug_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DrugListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> add_inoculation(
      access_token, pet_id, type, inoculation_date, drug_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'pet_id': pet_id,
      'type': type,
      'inoculation_date': inoculation_date,
      'drug_id': drug_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/add_inoculation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> signout(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/User/signout',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PointListResModel> pointHistory(access_token, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PointListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Mypage/point_history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PointListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AppInfoResModel> appInfo(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AppInfoResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/App/app_info',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AppInfoResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<IntentGuideResModel> intent_guide(access_token, type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'type': type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<IntentGuideResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/App/intent_guide',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = IntentGuideResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HospitalListResModel> favoriteHospitalList(access_token, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HospitalListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Mypage/my_favourite_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HospitalListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> setFavorite(access_token, hospital_id, is_set) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'hospital_id': hospital_id,
      'is_set': is_set
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Mypage/set_favourite',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> likeReview(access_token, review_id, is_set) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'review_id': review_id,
      'is_set': is_set
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/like_review',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> alarmSetting(
      access_token, alarm_yn, receive_other) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'alarm_yn': alarm_yn,
      'receive_other': receive_other
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Mypage/alarm_setting',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AlarmListResModel> alarm_list(access_token, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AlarmListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/App/alarm_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AlarmListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> read_alarm(access_token, alarm_uid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'alarm_uid': alarm_uid};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/App/read_alarm',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StringListResModel> feeling_list(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StringListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/feeling_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StringListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> review_write(
      access_token,
      medical_record_id,
      purpose,
      feelings,
      receipt_image,
      review_images,
      description,
      hospital_id,
      review_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'medical_record_id': medical_record_id,
      'purpose': purpose,
      'feelings': feelings,
      'receipt_image': receipt_image,
      'review_images': review_images,
      'description': description,
      'hospital_id': hospital_id,
      'review_id': review_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/review_write',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BtResModel> getBtItems(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BtResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/bt_items',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BtResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BtResModel> btSubItems(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BtResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/bt_sub_items',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BtResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BRResModel> btResult(access_token, pet_id, date) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'pet_id': pet_id,
      'date': date
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BRResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/blood_test_result',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BRResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BRResModel> btResultAll(access_token, pet_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'pet_id': pet_id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BRResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/bt_result_all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BRResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StringListResModel> regionSphere(access_token, region) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'region': region};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StringListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/region_sphere',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StringListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReservationListResModel> reservation_history(
      access_token, is_past, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'is_past': is_past,
      'page': page
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReservationListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Mypage/reservation_history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReservationListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> add_chart(
      access_token,
      is_sick,
      symptoms,
      hospital_id,
      veterinarian,
      vet_registration_number,
      description,
      prescription,
      writer,
      pet_id,
      disease) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'is_sick': is_sick,
      'symptoms': symptoms,
      'hospital_id': hospital_id,
      'veterinarian': veterinarian,
      'vet_registration_number': vet_registration_number,
      'description': description,
      'prescription': prescription,
      'writer': writer,
      'pet_id': pet_id,
      'disease': disease
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Chart/add_chart',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChartListResModel> chart_list(access_token, pet_id, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'pet_id': pet_id,
      'page': page
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChartListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Chart/chart_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChartListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StringListResModel> symptom_list(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StringListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Chart/symptom_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StringListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReservationResModel> check_reservation(
      access_token, reservation_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'reservation_id': reservation_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReservationResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Mypage/check_reservation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReservationResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChartListResModel> available_list(access_token, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChartListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/available_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChartListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ChartDetailResModel> view_chart(access_token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'id': id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChartDetailResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Chart/view_chart',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ChartDetailResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReviewResModel> check_review(
      access_token, review_id, medical_record_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'review_id': review_id,
      'medical_id': medical_record_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReviewResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/check_review',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReviewResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonResModel> makeBloodTest(
      access_token,
      bt_items,
      hospital_id,
      reserve_dt,
      pay_method,
      list_price,
      point,
      phone_number,
      email,
      pet_id,
      accident_yn,
      reservation_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'bt_items': bt_items,
      'hospital_id': hospital_id,
      'reserve_dt': reserve_dt,
      'pay_method': pay_method,
      'list_price': list_price,
      'point': point,
      'phone_number': phone_number,
      'email': email,
      'pet_id': pet_id,
      'accident_yn': accident_yn,
      'reservation_id': reservation_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/make_blood_test',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> cancelReservation(access_token, reservation_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'reservation_id': reservation_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Pay/cancel_reservation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReviewListResModel> recent_review_list(access_token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReviewListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/recent_review_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReviewListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReviewListResModel> review_list(
      access_token, page, hospital_id, keyword, purpose, order, user_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'page': page,
      'hospital_id': hospital_id,
      'keyword': keyword,
      'purpose': purpose,
      'order': order,
      'user_id': user_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReviewListResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/review_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReviewListResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> review_delete(access_token, review_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'review_id': review_id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/review_delete',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ReviewInfoResModel> review_info(access_token, hospital_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'hospital_id': hospital_id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ReviewInfoResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Review/review_info',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ReviewInfoResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<InoculationResModel> view_inoculation(
      access_token, type, pet_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'type': type,
      'pet_id': pet_id
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<InoculationResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/view_inoculation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = InoculationResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResModel> payStart(access_token, pet_id, hospital_id, point,
      merchant_uid, list_price, bt_items, reserve_dt) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'access_token': access_token,
      'pet_id': pet_id,
      'hospital_id': hospital_id,
      'point': point,
      'merchant_uid': merchant_uid,
      'list_price': list_price,
      'bt_items': bt_items,
      'reserve_dt': reserve_dt
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Pay/start',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AppInfo1ResModel> appStartInfo(dev_type) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'dev_type': dev_type};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AppInfo1ResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Pay/app_info',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AppInfo1ResModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SchedulesResModel> hosiptalSchInfo(access_token, hospital_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'access_token': access_token, 'hospital_id': hospital_id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SchedulesResModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/Home/hospital_sch_info',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SchedulesResModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
