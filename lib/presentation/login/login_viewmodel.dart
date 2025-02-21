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

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
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
  // TODO: implement inputIsAllInputsValid
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    (await _loginUseCase?.execute(// TODO: remove ?
        LoginUseCaseInput(loginObject.userName, loginObject.password)))?.fold(
        (failure) => {
              // Left -> Failure (message)
              print(failure.message)
            },
        (data) => {
              // Right -> Success (data)
              print(data.customer?.name)
            });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // data class operation same as kotlin
    _validate();
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

  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private functions

  _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isUserNameValid(loginObject.userName) &&
        _isPasswordValid(loginObject.password);
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

  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}
