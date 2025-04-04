import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter_advance_course/app/app_prefs.dart';
import 'package:flutter_advance_course/data/data_source/remote_data_source.dart';
import 'package:flutter_advance_course/data/network/app_api.dart';
import 'package:flutter_advance_course/data/network/dio_factory.dart';
import 'package:flutter_advance_course/data/network/network_info.dart';
import 'package:flutter_advance_course/data/repository/repository_impl.dart';
import 'package:flutter_advance_course/domain/repository/repository.dart';
import 'package:flutter_advance_course/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_advance_course/domain/usecase/login_usecase.dart';
import 'package:flutter_advance_course/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:flutter_advance_course/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharePrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharePrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client

  final dio = await instance<DioFactory>().getDio();
  // instance<DioFactory>() LIKE DioFactory(_appPreferences);

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}
