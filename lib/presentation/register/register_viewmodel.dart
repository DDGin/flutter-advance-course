import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_advance_course/app/function.dart';
import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/domain/usecase/register_usecase.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:flutter_advance_course/presentation/common/freezed_data_classes.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer_impl.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController _userNameStreamController =
      StreamController<String?>.broadcast();
  StreamController _emailStreamController =
      StreamController<String?>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String?>.broadcast();
  StreamController _mobileNumberStreamController =
      StreamController<String?>.broadcast();
  StreamController _profilePictureStreamController =
      StreamController<File?>.broadcast();
  StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject(
      EMPTYSTR, EMPTYSTR, EMPTYSTR, EMPTYSTR, EMPTYSTR, EMPTYSTR);

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
        LoadingState(StateRendererType.FULL_SCREEN_LOADING_PAGE, EMPTYSTR));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerObject.countryMobileCode,
            registerObject.userName,
            registerObject.email,
            registerObject.password,
            registerObject.mobileNumber,
            registerObject.profilePicture)))
        .fold(
            (failure) => {
                  inputState.add(
                      ErrorState(StateRendererType.POPUP_ERROR_STATE, EMPTYSTR))
                }, (data) {
      inputState.add(ContentState());
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _mobileNumberStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();

    super.dispose();
  }

  // ----- input -----
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputValidStreamController.sink;

  // ----- output -----
  @override
  Stream<bool> get outputUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName =>
      outputUserNameValid.map((isUserNameValid) =>
          isUserNameValid ? null : AppStrings.invalidUsername.tr());

  @override
  Stream<bool> get outputEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputEmailValid.map(
      (isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail.tr());

  @override
  Stream<bool> get outputMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : AppStrings.invalidMobileNumber.tr());

  @override
  Stream<bool> get outputPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword =>
      outputPasswordValid.map((isPasswordValid) =>
          isPasswordValid ? null : AppStrings.invalidPassword.tr());

  @override
  Stream<File?> get outputProfilePicture =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputValidStreamController.stream.map((_) => _validateAllInputs());

  // ----- public methods -----
  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      // update register view object with email value
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value on register view object
      registerObject = registerObject.copyWith(email: EMPTYSTR);
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      // update register view object with mobileNumber value
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset mobileNumber value on register view object
      registerObject = registerObject.copyWith(mobileNumber: EMPTYSTR);
    }
    _validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      // update register view object with countryCode value
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      // reset countryCode value on register view object
      registerObject = registerObject.copyWith(countryMobileCode: EMPTYSTR);
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      // update register view object with password value
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value on register view object
      registerObject = registerObject.copyWith(password: EMPTYSTR);
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      // update register view object with profilePicture
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture on register view object
      registerObject = registerObject.copyWith(profilePicture: EMPTYSTR);
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      // update register view object with username value
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset username value on register view object
      registerObject = registerObject.copyWith(userName: EMPTYSTR);
    }
    _validate();
  }

  // ----- private methods -----
  bool _isUserNameValid(String userName) {
    return userName.length >= 3;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAllInputs() {
    return registerObject.profilePicture.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty;
  }

  _validate() {
    inputIsAllInputsValid.add(null);
  }
}

abstract mixin class RegisterViewModelInput {
  setUserName(String userName);

  setEmail(String email);

  setPassword(String password);

  setMobileNumber(String mobileNumber);

  setCountryCode(String countryCode);

  setProfilePicture(File profilePicture);

  register();

  Sink get inputUserName;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputMobileNumber;

  Sink get inputProfilePicture;

  Sink get inputIsAllInputsValid;
}

abstract mixin class RegisterViewModelOutput {
  Stream<bool> get outputUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputMobileNumberValid;

  Stream<String?> get outputErrorMobileNumber;

  Stream<File?> get outputProfilePicture;

  Stream<bool> get outputIsAllInputsValid;
}
