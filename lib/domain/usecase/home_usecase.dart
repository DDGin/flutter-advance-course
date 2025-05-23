import 'package:dartz/dartz.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/domain/repository/repository.dart';
import 'package:flutter_advance_course/domain/usecase/base_usecase.dart';

import '../../data/network/failure.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
