import 'package:flutter_advance_course/data/network/app_api.dart';
import 'package:flutter_advance_course/data/request/request.dart';
import 'package:flutter_advance_course/data/responses/responses.dart';
import 'package:flutter_advance_course/domain/model/model.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgotPasswordResponse> forgotPassword(String email);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<HomeResponse> getHome();

  Future<StoreDetailsResponse> getStoreDetails1();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, "", "");
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.countryMobileCode,
        registerRequest.userName,
        registerRequest.email,
        registerRequest.password,
        registerRequest.mobileNumber,
        "");
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails1() async {
    return await _appServiceClient.getStoreDetails1();
  }
}
