import 'dart:async';
import 'dart:io';

import 'package:flutter_advance_course/app/function.dart';
import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/presentation/base/baseviewmodel.dart';
import 'package:flutter_advance_course/presentation/common/freezed_data_classes.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  var registerObject = RegisterObject(
      EMPTYSTR, EMPTYSTR, EMPTYSTR, EMPTYSTR, EMPTYSTR, EMPTYSTR);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _mobileNumberStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose();
  }

  // ----- input -----
  @override
  // TODO: implement inputEmail
  Sink get inputEmail => _emailStreamController.sink;

  @override
  // TODO: implement inputMobileNumber
  Sink get inputMobileNumber => throw _mobileNumberStreamController.sink;

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputProfilePicture
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  // TODO: implement inputIsAllInputValid
  Sink get inputIsAllInputsValid => _isAllInputValidStreamController.sink;

  // ----- output -----
  @override
  Stream<bool> get outputUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputUserNameValid.map(
      (isUserNameValid) => isUserNameValid ? null : AppStrings.errorUserName);

  @override
  Stream<bool> get outputEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.errorEmail);

  @override
  Stream<bool> get outputMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : AppStrings.errorMobileNumber);

  @override
  Stream<bool> get outputPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.errorPassword);

  @override
  Stream<File> get outputProfilePicture =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  // TODO: implement outputIsAllInputsValid
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputValidStreamController.stream.map((_) => _validateAllInputs());

  // ----- public methods -----
  @override
  setEmail(String email) {
    if (isEmailValid(email)) {
      // update register view object with email value
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value on register view object
      registerObject = registerObject.copyWith(email: EMPTYSTR);
    }
  }

  @override
  setMobileNumber(String mobileNumber) {
    if (_isMobileNumberValid(mobileNumber)) {
      // update register view object with mobileNumber value
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset mobileNumber value on register view object
      registerObject = registerObject.copyWith(mobileNumber: EMPTYSTR);
    }
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
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      // update register view object with password value
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset password value on register view object
      registerObject = registerObject.copyWith(password: EMPTYSTR);
    }
  }

  @override
  setProfilePicture(File profilePicture) {
    if (profilePicture.path.isNotEmpty) {
      // update register view object with profilePicture
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      // reset profilePicture on register view object
      registerObject = registerObject.copyWith(profilePicture: EMPTYSTR);
    }
  }

  @override
  setUserName(String userName) {
    if (_isUserNameValid(userName)) {
      // update register view object with username value
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset username value on register view object
      registerObject = registerObject.copyWith(userName: EMPTYSTR);
    }
  }

  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  // ----- private methods -----
  bool _isUserNameValid(String userName) {
    return userName.length >= 8 && userName.length <= 32;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 9;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  _validateAllInputs() {}
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
