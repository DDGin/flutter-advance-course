import 'dart:async';

import 'package:flutter_advance_course/domain/usecase/login_usecase.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:flutter_advance_course/presentation/common/freezed_data_classes.dart';

class LoginViewModel
    implements BaseViewModel, LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  // Left -> Failure (message)
                  failure.message
                },
            (data) => {
                  // Right -> Success (data)
                  data.customer?.name
                });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // data class operation same as kotlin
  }

  // outputs
  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUserNameValid(username));

  // private functions
  _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  _isUserNameValid(String username) {
    return username.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  // three functions
  setUserName(String userName);

  setPassword(String password);

  login();

  // two sinks
  Sink get inputUserName;

  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;
}
