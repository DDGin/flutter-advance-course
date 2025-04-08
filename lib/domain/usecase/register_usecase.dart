import 'package:dartz/dartz.dart';
import 'package:flutter_advance_course/app/function.dart';
import 'package:flutter_advance_course/data/network/failure.dart';
import 'package:flutter_advance_course/data/request/request.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/repository/repository.dart';
import 'package:flutter_advance_course/domain/usecase/base_usecase.dart';

class RegisterUsecase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;

  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return _repository.register(RegisterRequest(
        input.countryMobileCode,
        input.userName,
        input.email,
        input.password,
        input.mobileNumber,
        input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterUseCaseInput(this.countryMobileCode, this.userName, this.email,
      this.password, this.mobileNumber, this.profilePicture);
}
