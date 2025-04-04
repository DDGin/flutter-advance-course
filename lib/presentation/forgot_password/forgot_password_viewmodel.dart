import 'dart:async';

import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/domain/usecase/forgot_password_usecase.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer.dart';

import '../../app/function.dart';
import '../common/state_renderfer/state_renderfer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  StreamController _emailStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  var email = "";

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  forgotPassword() async {
    inputState
        .add(LoadingState(StateRendererType.POPUP_LOADING_STATE, EMPTYSTR));
    (await _forgotPasswordUseCase.execute(email)).fold(
        (failure) => inputState.add(
            ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message)),
        (supportMessage) => inputState.add(SuccessState(supportMessage)));
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract mixin class ForgotPasswordViewModelInputs {
  setEmail(String email);

  forgotPassword();

  Sink get inputEmail;

// TODO: Is that we need inputIsAllInputValid here
  Sink get inputIsAllInputValid;
}

abstract mixin class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
