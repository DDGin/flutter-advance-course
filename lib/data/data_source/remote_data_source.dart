import 'package:flutter_advance_course/data/network/app_api.dart';
import 'package:flutter_advance_course/data/request/request.dart';
import 'package:flutter_advance_course/data/responses/responses.dart';
import 'package:flutter_advance_course/domain/model/model.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, "", "");
  }
}
