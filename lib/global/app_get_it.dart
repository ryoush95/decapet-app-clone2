
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:decapet/global/app_api.dart';
import 'package:decapet/models/dto/user_dto.dart';
import 'package:decapet/stores/user_info_store.dart';

import 'global.dart';
import 'local_service.dart';

final getIt = GetIt.instance;

setupLocator() async {
  // Register EventBus
  getIt.registerSingleton(EventBus());

  // API
  final Dio dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: true));
  getIt.registerLazySingleton<Api>(() => Api(dio, baseUrl: API_BASE_URL));

  // Store
  getIt.registerSingleton(UserInfoStore());

  // Register ScopedModels
  //locator.registerFactory<SplashModel>(() => SplashModel());
  //locator.registerFactory<LoginModel>(() => LoginModel());
  //locator.registerFactory<SignupModel>(() => SignupModel());
  //locator.registerFactory<FindModel>(() => FindModel());
}
